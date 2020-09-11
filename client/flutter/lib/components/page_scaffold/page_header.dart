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
    final titleWrapper = Padding(
      padding: showBackButton
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: TextStyle(color: Constants.accentNavyColor),
      ),
    );
    final leading = showBackButton ? BackButton() : null;
    final iconThemeData = IconThemeData(color: Constants.accentNavyColor);
    final actions = <Widget>[if (trailing != null) trailing];
    final bgColor = appBarColor ?? Colors.transparent;
    final bottomBorder = Border(
        bottom:
            BorderSide(color: borderColor, style: BorderStyle.solid, width: 1));
    return inSliver
        ? SliverAppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: leading,
            iconTheme: iconThemeData,
            title: titleWrapper,
            backgroundColor: bgColor,
            actions: actions,
            shape: bottomBorder,
            elevation: 0,
            pinned: true,
          )
        : AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: leading,
            iconTheme: iconThemeData,
            title: titleWrapper,
            backgroundColor: bgColor,
            actions: actions,
            shape: bottomBorder,
            elevation: 0,
          );
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
