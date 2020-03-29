import 'package:WHOFlutter/components/page_header.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String subtitle;

  final List<Widget> body;

  final EdgeInsets padding;
  final bool showBackButton;

  PageScaffold({
    @required this.body,
    @required this.title,
    this.subtitle = "WHO Coronavirus App",
    this.padding = EdgeInsets.zero,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: this.padding,
          child: CustomScrollView(slivers: [
            SliverAppBar(
              // Hide the built-in icon for now
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: PageHeader(context,
                  title: this.title,
                  subtitle: this.subtitle,
                  padding: this.padding,
                  showBackButton: this.showBackButton),
              expandedHeight: 120,
            ),
            ...this.body
          ]),
        ));
  }
}
