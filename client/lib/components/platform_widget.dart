import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  /// Android
  final Widget material;

  /// IOS
  final Widget cupertino;

  const PlatformWidget({
    Key key,
    @required this.material,
    @required this.cupertino,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        widget = material;
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        widget = cupertino;
        break;
    }
    return widget;
  }
}
