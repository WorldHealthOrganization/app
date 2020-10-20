import 'package:flutter/material.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/constants.dart';

class PageButton extends StatefulWidget {
  final Color backgroundColor;
  final String title;
  final String description;
  final double borderRadius;
  final Function onPressed;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle titleStyle;
  final Color descriptionColor;

  /// The amount of time elapsed before subsequent taps are recorded. Can be
  /// increased for actions that take a long time to complete.
  final Duration debounceDuration;
  final double verticalPadding;
  final double horizontalPadding;

  // TODO: Let's move the positional args to named args.
  const PageButton(
    this.backgroundColor,
    this.title,
    this.onPressed, {
    this.description = '',
    this.borderRadius = 16,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 8.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.titleStyle,
    this.descriptionColor,
    // 200ms works, 300ms is just for good measure.
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  _PageButtonState createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  bool enabled = true;

  void _onPressed() {
    if (!enabled) return;
    widget.onPressed();
    _debounce();
  }

  Future<void> _debounce() async {
    setState(() {
      enabled = false;
    });

    await Future.delayed(widget.debounceDuration);
    setState(() {
      enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: widget.onPressed != null ? _onPressed : null,
      disabledBackgroundColor: Constants.neutralTextLightColor.withOpacity(0.4),
      disabledForegroundColor: Colors.white,
      borderRadius: BorderRadius.circular(
        widget.borderRadius,
      ),
      backgroundColor: widget.backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.verticalPadding,
          horizontal: widget.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment,
          mainAxisAlignment: widget.mainAxisAlignment,
          children: <Widget>[
            Text(
              widget.title,
              textAlign: TextAlign.left,
              style: widget.titleStyle?.copyWith(
                    letterSpacing: Constants.buttonTextSpacing,
                  ) ??
                  TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: Constants.buttonTextSpacing,
                    fontSize: 18,
                  ),
            ),
            // Makes sure text is centered properly when no description is provided
            SizedBox(height: widget.description.isNotEmpty ? 4 : 0),
            widget.description.isNotEmpty
                ? Text(
                    widget.description,
                    textAlign: TextAlign.left,
                    textScaleFactor: (0.9 + 0.5 * contentScale(context)) *
                        MediaQuery.textScaleFactorOf(context),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: widget.descriptionColor ?? Color(0xFFC9CDD6),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
