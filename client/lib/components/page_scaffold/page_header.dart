import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
// Used to get latest AppBar features while remaining on Flutter's stable branch

class PageHeader extends StatelessWidget {
  ///Overrides headerWidget parameter
  final String title;

  /// passing a widget into the header
  final Widget headerWidget;

  /// A unique tag to animate a header between pages.
  final String heroTag;
  final Color borderColor;
  final TextStyle titleStyle;
  final Color appBarColor;

  /// Whether this header must be wrapped in a sliver
  final bool inSliver;

  /// An extra widget to show on the trailing side of the header
  final Widget trailing;

  final Widget appBarBottom;

  final bool showBackButton;

  PageHeader({
    this.title,
    this.headerWidget,
    this.heroTag,
    this.showBackButton = true,
    this.titleStyle,
    this.borderColor = const Color(0xffC9CDD6),
    this.appBarColor,
    this.inSliver = true,
    this.trailing,
    this.appBarBottom,
  });

  @override
  Widget build(BuildContext context) {
    final titleWrapper = Padding(
        padding: showBackButton
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            title != null
                ? Text(
                    title,
                    style: TextStyle(color: Constants.accentNavyColor),
                  )
                : headerWidget,
          ],
        ));
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
            primary: true,
            bottom: appBarBottom,
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
            primary: true,
            bottom: appBarBottom,
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
