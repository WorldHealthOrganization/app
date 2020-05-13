import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
// Used to get latest AppBar features while remaining on Flutter's stable branch

class PageHeader extends StatelessWidget {
  final String title;
  final String heroTag;
  final Color borderColor;
  final TextStyle titleStyle;
  final Color appBarColor;
  final bool inSliver;
  final Widget trailing;

  final bool showBackButton;

  PageHeader({
    @required this.title,
    this.heroTag,
    this.showBackButton = true,
    this.titleStyle,
    this.borderColor = const Color(0xffC9CDD6),
    this.appBarColor,
    this.inSliver = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    child = Column(
      children: <Widget>[
        AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: showBackButton ? BackButton() : null,
          iconTheme: IconThemeData(color: Constants.accentNavyColor),
          title: Padding(
            padding: showBackButton
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: TextStyle(color: Constants.accentNavyColor),
            ),
          ),
          backgroundColor: appBarColor ?? Colors.transparent,
          elevation: 0,
          actions: <Widget>[if (trailing != null) trailing],
        ),
        Divider(height: 1, thickness: 1, color: borderColor)
      ],
    );

    if (inSliver) child = SliverToBoxAdapter(child: child);

    return child;
  }

  static Widget buildTitle(String title,
      {TextStyle textStyle,
      TypographyVariant variant = TypographyVariant.header}) {
    return Semantics(
      header: true,
      namesRoute: true,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AutoSizeThemedText(title,
              variant: variant,
              maxLines: 1,
              minFontSize: 8,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: textStyle)),
    );
  }
}
