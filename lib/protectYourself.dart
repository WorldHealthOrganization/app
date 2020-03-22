import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: PageView(
      children: <Widget>[
            Slide("assets/washHands.png", "Wash your hand often with soap and running water frequently", context),
            Slide("assets/cough.png", "When coughing and sneezing cover mouth and nose with flexed elbow or tissue", context),
            Slide("assets/cough.png", "Throw tissue into closed bin immediately after use", context),
            Slide("assets/washHands.png", "Wash your hands frquently", context),
            Slide("assets/distance.png", "Avoid close contact and keep the physical distancing", context),
            Slide("assets/distance.png", "Seek medical care early if you have fever, cough, and difficulty breathing", context),
      ],
        ),
          ));
  }
}

Widget Slide(String imgSrc, String message, BuildContext context) {
  double width = MediaQuery.of(context).size.width * 9/10;
  double height = MediaQuery.of(context).size.height/2;

  return Container(
    child: Card(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(imgSrc), width: width, height: height,),
          Text(message, textScaleFactor: 1.7, textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}
