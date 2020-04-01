import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {

  ArrowButton({
    @required this.title,
    @required this.color,
    @required this.onPressed,
    this.textStyle
  });

  final Color color;
  final String title;
  final Function onPressed;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 23),
        color: this.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(this.title, style: this.textStyle ?? TextStyle(),),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
        onPressed: this.onPressed);
  }
}
