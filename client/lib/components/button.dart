import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final VoidCallback onPressed;
  final Duration debounceDuration;

  const Button({
    Key key,
    this.color,
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.padding,
    this.child,
    this.onPressed,
    this.debounceDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Debouncer(
      debounceDuration: debounceDuration,
      onCallback: onPressed,
      builder: (context, callback) {
        return FlatButton(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          color: color,
          padding: padding,
          child: child,
          onPressed: callback,
        );
      },
    );
  }
}

typedef DebounceBuilder = Widget Function(
  BuildContext context,
  VoidCallback callback,
);

class _Debouncer extends StatefulWidget {
  const _Debouncer({
    Key key,
    @required this.builder,
    @required this.onCallback,
    @required this.debounceDuration,
  }) : super(key: key);

  final Duration debounceDuration;
  final VoidCallback onCallback;
  final DebounceBuilder builder;

  @override
  __DebouncerState createState() => __DebouncerState();
}

class __DebouncerState extends State<_Debouncer> {
  bool enabled = true;

  void _onPressed() {
    if (!enabled) return;

    widget.onCallback();

    _debounce();
  }

  Future<void> _debounce() async {
    setState(() => enabled = false);

    await Future.delayed(widget.debounceDuration);

    setState(() => enabled = true);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _onPressed);
}
