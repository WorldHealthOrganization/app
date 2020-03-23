import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './constants.dart';

class PageButton extends StatelessWidget {
  const PageButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    const tall = 812.0;
    const short = 480.0;
    double scale = ((height - short) / (tall - short)).clamp(1.0, 2.0);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(16.0 + 16.0 * (scale - 1.0)),
        onPressed: onPressed,
        color: Constants.primaryColor,
        child: Text(
          title,
          textScaleFactor: scale,
        ),
      ),
    );
  }
}
