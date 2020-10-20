import 'package:flutter/material.dart';
import 'package:who_app/constants.dart';

class Button extends StatelessWidget {
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final VoidCallback onPressed;
  final Duration debounceDuration;
  final ButtonType buttonType;

  const Button({
    Key key,
    this.backgroundColor = Constants.backgroundColor,
    this.disabledBackgroundColor,
    this.foregroundColor = Colors.black,
    this.disabledForegroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.padding,
    this.child,
    this.onPressed,
    this.debounceDuration = const Duration(milliseconds: 200),
    this.buttonType = ButtonType.Text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Debouncer(
      debounceDuration: debounceDuration,
      onCallback: onPressed,
      builder: (context, callback) {
        switch (buttonType) {
          case ButtonType.Elevated:
            return ElevatedButton(
              child: child,
              style: style,
              onPressed: callback,
            );
          case ButtonType.Text:
            return TextButton(
              style: style,
              child: child,
              onPressed: callback,
            );
          case ButtonType.Outline:
            return OutlinedButton(
              style: style,
              child: child,
              onPressed: callback,
            );
          default:
            return ElevatedButton(
              child: child,
              style: style,
              onPressed: callback,
            );
        }
      },
    );
  }

  ButtonStyle get style => ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return 0;
          } else {
            return buttonType == ButtonType.Elevated ? 20 : 0;
          }
        }),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ??
                  Constants.neutralTextLightColor.withOpacity(.4);
            } else {
              return backgroundColor;
            }
          },
        ),
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disabledForegroundColor;
          } else {
            return foregroundColor;
          }
        }),
        padding: MaterialStateProperty.all(
          padding,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: borderRadius),
        ),
      );
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

enum ButtonType {
  Text,
  Elevated,
  Outline,
}
