import 'package:WHOFlutter/components/page_header.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
      this.subtitle = "WHO COVID-19 App",
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
                  flexibleSpace: PageHeader(context, title: this.title, subtitle: this.subtitle, padding: this.padding, showBackButton: this.showBackButton),
                  expandedHeight: 120,
                ),
                ...this.body,
                SliverToBoxAdapter(
                child: SizedBox(height: 70),
              ),
              ]),
              if(this.showShareBottomBar) Positioned(
                bottom: 0,
                child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(.85),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 28,
                    onPressed: ()=>Share.share(S.of(context).commonWhoAppShareIconButtonDescription),
                  ),
                ),
              ))
            ],
          ),
        ));
  }

}
