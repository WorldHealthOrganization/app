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
  final Color headingBorderColor;
  final bool disableBackButton;
  final TextStyle headerTitleStyle;
  final TypographyVariant headerTypographyVariant;
  final Widget header;

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
    this.headingBorderColor = const Color(0xffC9CDD6),
    this.beforeHeader = const <Widget>[],
    this.disableBackButton = false,
    this.headerTitleStyle,
    this.headerTypographyVariant = TypographyVariant.header,
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
                          disableBackButton: disableBackButton,
                          titleStyle: headerTitleStyle,
                          titleTypographyVariant: this.headerTypographyVariant,
                        )),
                  ...this.body,
                  SliverToBoxAdapter(
                    child: SizedBox(height: 70),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
