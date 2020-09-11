import 'package:who_app/api/alerts.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String heroTag;
  final List<Widget> body;
  final List<Widget> beforeHeader;
  final Color color;
  final Color appBarColor;
  final Color headingBorderColor;
  final bool showBackButton;
  final TextStyle headerTitleStyle;
  final Widget header;
  final Widget trailing;

  final bool showHeader;

  final EdgeInsets padding;

  PageScaffold({
    @required this.body,
    this.title,
    this.heroTag,
    this.header,
    this.showHeader = true,
    this.padding = EdgeInsets.zero,
    this.color = Constants.greyBackgroundColor,
    this.appBarColor,
    this.headingBorderColor = const Color(0xffC9CDD6),
    this.beforeHeader = const <Widget>[],
    this.showBackButton = true,
    this.headerTitleStyle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: this.color,
      child: Padding(
        padding: this.padding,
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              // Disables scrolling when there's insufficient content to scroll
              primary: false,
              slivers: [
                ...this.beforeHeader,
                if (this.showHeader)
                  (this.header ??
                      PageHeader(
                        title: this.title,
                        heroTag: this.heroTag ?? this.title,
                        borderColor: headingBorderColor,
                        showBackButton: showBackButton,
                        titleStyle: headerTitleStyle,
                        appBarColor: appBarColor ?? color,
                        trailing: trailing,
                      )),
                ...this.body,
                SliverToBoxAdapter(
                  child: SizedBox(height: 170),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Alerts extends StatelessWidget {
  const Alerts({
    Key key,
    @required this.alerts,
  }) : super(key: key);

  final List<Alert> alerts;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        bottom: false,
        maintainBottomViewPadding: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: alerts.map((alert) => _Alert(alert: alert)).toList(),
        ),
      ),
    );
  }
}

class _Alert extends StatelessWidget {
  const _Alert({
    Key key,
    this.topPadding = 0,
    @required this.alert,
  }) : super(key: key);

  final double topPadding;
  final Alert alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: topPadding,
          ),
          ThemedText(
            alert.title,
            variant: TypographyVariant.headerSmall,
            style: TextStyle(color: Colors.white),
          ),
          ThemedText(
            alert.body,
            variant: TypographyVariant.body,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
