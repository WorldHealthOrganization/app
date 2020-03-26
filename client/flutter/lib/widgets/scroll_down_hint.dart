import 'dart:async';

import 'package:flutter/material.dart';

class ScrollDownHint extends StatefulWidget {
  const ScrollDownHint({
    Key key,
    this.child,
    @required this.controller,
    this.margin = 10.0,
  })  : assert(controller != null),
        super(key: key);

  final Widget child;

  final double margin;

  final ScrollController controller;

  State<ScrollDownHint> createState() => _ScrollDownHintState();
}

class _ScrollDownHintState extends State<ScrollDownHint> {
  bool _atBottom = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
    _handleControllerChanged();
  }

  @override
  void didUpdateWidget(ScrollDownHint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      widget.controller.removeListener(_handleControllerChanged);
      widget.controller.addListener(_handleControllerChanged);
      _handleControllerChanged();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    if (!widget.controller.hasClients || !widget.controller.position.haveDimensions) {
      return;
    }
    bool atBottom = widget.controller.position.pixels >= widget.controller.position.maxScrollExtent - widget.margin;
    if (atBottom != _atBottom) {
      setState(() {
        _atBottom = atBottom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final double gradientSize = 48.0 * MediaQuery.of(context).textScaleFactor;
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            scheduleMicrotask(_handleControllerChanged);
            return widget.child;
          },
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: ExcludeSemantics(
            child: IgnorePointer(
              ignoring: _atBottom,
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      backgroundColor.withOpacity(0.0),
                      backgroundColor.withOpacity(_atBottom ? 0.0 : 1.0),
                    ],
                    stops: <double>[0.0, 0.5],
                  ),
                ),
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                padding: EdgeInsets.only(top: gradientSize / 2.0),
                child: SizedBox(width: double.infinity, height: 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
