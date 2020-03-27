import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './constants.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.lightColor = false,
  }) : super(key: key);

  final String title;
  final Function onPressed;
  final bool lightColor;

  @override
  Widget build(BuildContext context) {
    double scale = contentScale(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Constants.primaryColor,
                width: 1.5,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: EdgeInsets.all(16.0 + 16.0 * (scale - 1.0)),
        onPressed: onPressed,
        color: lightColor ? Colors.white : Constants.primaryColor,
        child: Text(
          title,
          textScaleFactor: scale * 1.2,
          style: TextStyle(
              color: lightColor ? Constants.primaryColor : Colors.white),
        ),
      ),
    );
  }
}
