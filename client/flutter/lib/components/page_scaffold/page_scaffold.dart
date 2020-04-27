import './page_header.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final String title;

  final List<Widget> body;

  final EdgeInsets padding;
  final bool showBackButton;
  final bool showLogoInHeader;
  final bool announceRouteManually;
  final Color dividerColor;

  PageScaffold({
    @required this.body,
    @required this.title,
    this.padding = EdgeInsets.zero,
    this.showBackButton = false,
    this.showLogoInHeader = false,
    this.announceRouteManually = false,
    this.dividerColor = const Color(0xffC9CDD6),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xfff6f5f5),
        child: Padding(
          padding: this.padding,
          child: Stack(
            children: <Widget>[
              CustomScrollView(slivers: [
                PageHeader(
                  title: this.title,
                  padding: this.padding,
                  showBackButton: this.showBackButton,
                  showLogo: this.showLogoInHeader,
                  announceRouteManually: announceRouteManually,
                  dividerColor: this.dividerColor,
                ),
                ...this.body,
                SliverToBoxAdapter(
                  child: SizedBox(height: 70),
                ),
              ]),
            ],
          ),
        ));
  }
}
