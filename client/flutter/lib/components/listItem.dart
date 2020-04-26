import 'package:flutter/cupertino.dart';

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
          this.titleWidget ?? Container(),
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
