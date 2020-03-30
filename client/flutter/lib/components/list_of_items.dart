import 'package:WHOFlutter/components/page_header.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ListOfItems extends StatelessWidget {
  final String title;

  final List<Widget> listOfItems;

  ListOfItems(this.listOfItems, {this.title = 'Provide Title'});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                leading: SizedBox(),
                flexibleSpace: PageHeader(context, title: this.title),
                expandedHeight: 120,
              ),
              SliverList(
                delegate: SliverChildListDelegate(this.listOfItems),
              ),

              /// Pad by the Positioned container at the bottom so we can scroll
              /// past it. Plus some padding.
              SliverToBoxAdapter(
                child: SizedBox(height: 70),
              )
            ],
          ),
          Positioned(
              bottom: 0.0,
              child: Center(
                  child: Container(
                color: Color(0xF8ffffff),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: IconButton(
                          onPressed: () => Share.share(S.of(context).commonWhoAppShareIconButtonDescription),
                          icon: Icon(
                            Icons.share,
                            size: 22,
                          )),
                    )),
              ))),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Widget titleWidget;
  final String message;

  ListItem({this.titleWidget, this.message = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          this.titleWidget ?? Divider(),
          Text(
            this.message,
            style: TextStyle(fontSize: 21),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class EmojiHeader extends StatelessWidget {
  EmojiHeader(this.emoji);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.emoji,
        textScaleFactor: 6,
      ),
    );
  }
}
