import './page_header.dart';
import 'package:flutter/cupertino.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String heroTag;
  final List<Widget> body;

  final bool showHeader;

  final EdgeInsets padding;

  PageScaffold({
    @required this.body,
    this.title,
    this.heroTag,
    this.padding = EdgeInsets.zero,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Stack(
        children: <Widget>[
          CustomScrollView(slivers: [
            if (this.showHeader)
              PageHeader(
                title: this.title,
                heroTag: this.heroTag ?? this.title,
              ),
            ...this.body,
            SliverToBoxAdapter(
              child: SizedBox(height: 70),
            ),
          ]),
        ],
      ),
    );
  }
}
