import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ListOfItems extends StatelessWidget {
  final List<ListItem> listOfItems;
  ListOfItems(this.listOfItems);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Container(),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildListDelegate(this.listOfItems),
              ),
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
                      onPressed: () => Share.share('Check out the official COVID-19 Guide App https://www.who.int/covid-19-app%27'),
                      icon: Icon(Icons.share, size: 22,)
                    ),
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
            textScaleFactor: 1.5,
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
