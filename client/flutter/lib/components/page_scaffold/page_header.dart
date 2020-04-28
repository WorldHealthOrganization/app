import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Used to get latest AppBar features while remaining on Flutter's stable branch

class PageHeader extends StatelessWidget {
  final String title;
  final String heroTag;

  final bool disableBackButton;

  /// True if [PageHeader] wouldn't be announced via the screen reader if it wasn't
  /// wrapped in a [Semantics] widget. E.g. when opening a page with
  /// [SwipeableOpenContainer]

  PageHeader({
    @required this.title,
    this.heroTag,
    this.disableBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      heroTag: this.heroTag ?? this.title,
      leading: this.disableBackButton ? Container() : null,
      largeTitle: buildTitle(this.title),
    );
  }

  static const textColor = Color(0xff1A458E);

  static Widget buildTitle(String title) {
    return Semantics(
      header: true,
      namesRoute: true,
      child: AutoSizeText(title,
          maxLines: 1,
          minFontSize: 8,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              letterSpacing: -0.5)),
    );
  }
}
