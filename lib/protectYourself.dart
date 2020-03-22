import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
          Container(
            child: PageView(
      children: <Widget>[
            Slide("assets/washHands.png", "Wash your hand often with soap and running water frequently", context),
            Slide("assets/cough.png", "Wash your hand often with soap and running water frequently", context),
            Slide("assets/cough.png", "Wash your hand often with soap and running water frequently", context),
            Slide("assets/washHands.png", "Wash your hand often with soap and running water frequently", context),
      ],
        ),
          ));
  }
}

Widget Slide(String imgSrc, String message, BuildContext context) {
  double width = MediaQuery.of(context).size.width * 9/10;
  double height = MediaQuery.of(context).size.height/2;

  return Center(
    child: Card(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(imgSrc), width: width, height: height,),
          Text(message, textScaleFactor: 1.3, textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}
