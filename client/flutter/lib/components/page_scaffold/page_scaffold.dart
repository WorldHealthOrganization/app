import './page_header.dart';
import 'package:flutter/material.dart';

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
    return Material(
        color: Color(0xfff6f5f5),
        child: Padding(
          padding: this.padding,
          child: Stack(
            children: <Widget>[
              CustomScrollView(slivers: [
                PageHeader(
                  title: this.title,
                  subtitle: this.subtitle,
                  padding: this.padding,
                  showBackButton: this.showBackButton,
                  showLogo: this.showLogoInHeader,
                  announceRouteManually: announceRouteManually,
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
