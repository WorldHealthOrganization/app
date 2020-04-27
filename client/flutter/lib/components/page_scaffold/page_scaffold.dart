import './page_header.dart';
import 'package:flutter/cupertino.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String heroTag;
  final List<Widget> body;

  final EdgeInsets padding;

  PageScaffold({
    @required this.body,
    @required this.title,
    this.heroTag,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Stack(
        children: <Widget>[
          CustomScrollView(slivers: [
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
