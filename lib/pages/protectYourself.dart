import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
          Container(
            child: PageView(
      children: <Widget>[
            slide("assets/washHands.png",AppLocalizations.of(context).translate("washHands"), context),
            slide("assets/cough.png", AppLocalizations.of(context).translate("cougningAndSneezing"), context),
            slide("assets/cough.png", AppLocalizations.of(context).translate("throwAwayTissue"), context),
            slide("assets/washHands.png", AppLocalizations.of(context).translate("washHandsFrequently"), context),
            slide("assets/distance.png", AppLocalizations.of(context).translate("socialDistancing"), context),
            slide("assets/distance.png", AppLocalizations.of(context).translate("seekMedicalCare"), context),
      ],
        ),
          ));
  }
}

Widget slide(String imgSrc, String message, BuildContext context) {
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
