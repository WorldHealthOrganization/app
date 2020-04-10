import './page_header.dart';
import './share_bar.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String subtitle;

  final List<Widget> body;

  final BuildContext context; // TODO: Remove this
  final EdgeInsets padding;
  final bool showBackButton;
  final bool showShareBottomBar;
  final bool showLogoInHeader;

  PageScaffold(
    this.context, {
    @required this.body,
    @required this.title,
    this.showShareBottomBar = false,
    this.subtitle = "COVID-19",
    this.padding = EdgeInsets.zero,
    this.showBackButton = true,
    this.showLogoInHeader = false,
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
                ),
                ...this.body,
                SliverToBoxAdapter(
                  child: SizedBox(height: 70),
                ),
              ]),
              if (this.showShareBottomBar) ShareBar()
            ],
          ),
        ));
  }
}
