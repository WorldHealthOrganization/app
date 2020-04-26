import './page_header.dart';
import 'package:flutter/cupertino.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String subtitle;

  final List<Widget> body;

  final EdgeInsets padding;
  final bool showBackButton;
  final bool showLogoInHeader;
  final bool announceRouteManually;

  PageScaffold({
    @required this.body,
    @required this.title,
    this.subtitle = "COVID-19",
    this.padding = EdgeInsets.zero,
    this.showBackButton = true,
    this.showLogoInHeader = false,
    this.announceRouteManually = false,
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
              announceRouteManually: announceRouteManually,
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
