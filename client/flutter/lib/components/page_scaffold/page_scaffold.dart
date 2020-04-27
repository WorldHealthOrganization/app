import './page_header.dart';
import 'package:flutter/cupertino.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String heroTag;
  final List<Widget> body;
  final List<Widget> beforeHeader;
  final Color color;
  final Color headingBorderColor;
  final bool disableBackButton;
  final double headerFontSize;
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
    this.color = CupertinoColors.white,
    this.headingBorderColor = const Color(0xffC9CDD6),
    this.beforeHeader = const <Widget>[],
    this.disableBackButton = false,
    this.headerFontSize = 34,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color,
      child: Padding(
        padding: this.padding,
        child: Stack(
          children: <Widget>[
            CustomScrollView(
                physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
                slivers: [
                  ...this.beforeHeader,
                  if (this.showHeader)
                    (this.header ??
                        PageHeader(
                          title: this.title,
                          heroTag: this.heroTag ?? this.title,
                          borderColor: headingBorderColor,
                          disableBackButton: disableBackButton,
                          fontSize: headerFontSize,
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
