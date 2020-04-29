import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Used to get latest AppBar features while remaining on Flutter's stable branch

class PageHeader extends StatelessWidget {
  final String title;
  final String heroTag;
  final Color borderColor;
  final TextStyle titleStyle;

  final bool disableBackButton;

  PageHeader({
    @required this.title,
    this.heroTag,
    this.disableBackButton = false,
    this.titleStyle = const TextStyle(fontSize: 34),
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      border: Border(
        bottom: BorderSide(
          color: borderColor,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      transitionBetweenRoutes: true,
      backgroundColor: CupertinoColors.white.withOpacity(0.85),
      heroTag: this.heroTag ?? this.title,
      leading: this.disableBackButton ? Container() : null,
      largeTitle: buildTitle(this.title, textStyle: titleStyle),
    );
  }

  static const textColor = Color(0xff1A458E);

  static Widget buildTitle(String title,
      {TextStyle textStyle = const TextStyle(fontSize: 34)}) {
    return Semantics(
      header: true,
      namesRoute: true,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AutoSizeText(title,
              maxLines: 1,
              minFontSize: 8,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5)
                  .merge(textStyle))),
    );
  }
}
