import './page_header.dart';
import './share_bar.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final String subtitle;

  final List<Widget> body;

  final BuildContext context;
  final EdgeInsets padding;
  final bool showBackButton;
  final bool showShareBottomBar;

  PageScaffold(this.context,
      {@required this.body,
      @required this.title,
       this.showShareBottomBar = false,
      this.subtitle = "COVID-19 App",
      this.padding = EdgeInsets.zero,
      this.showBackButton = true,
      });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.grey.shade200,
        child: Padding(
          padding: this.padding,
          child: Stack(
            children: <Widget>[
              CustomScrollView(slivers: [
                SliverAppBar(
                  // Hide the built-in icon for now
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  flexibleSpace: PageHeader(title: this.title, subtitle: this.subtitle, padding: this.padding, showBackButton: this.showBackButton),
                  expandedHeight: 120,
                ),
                ...this.body,
                SliverToBoxAdapter(
                child: SizedBox(height: 70),
              ),
              ]),
              if(this.showShareBottomBar) ShareBar()
            ],
          ),
        ));
  }

}
