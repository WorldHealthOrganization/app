import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  PageController pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      PageView(
        controller: pageController,
        children: <Widget>[
          slide("assets/washHands.png",
              AppLocalizations.of(context).translate("washHands"), context, 0),
          slide(
              "assets/cough.png",
              AppLocalizations.of(context).translate("cougningAndSneezing"),
              context, 1),
          slide(
              "assets/cough.png",
              AppLocalizations.of(context).translate("throwAwayTissue"),
              context,2),
          slide(
              "assets/washHands.png",
              AppLocalizations.of(context).translate("washHandsFrequently"),
              context,3),
          slide(
              "assets/distance.png",
              AppLocalizations.of(context).translate("socialDistancing"),
              context,4),
          slide(
              "assets/distance.png",
              AppLocalizations.of(context).translate("seekMedicalCare"),
              context,5),
        ],
      ),
    );
  }

  Widget slide(String imgSrc, String message, BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width * 9 / 10;

    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(imgSrc),
              width: width,
            ),
            Text(
              message,
              textScaleFactor: 1.7,
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 10,
            ),
            Center(child: Text("Progress: "+(((index+1)/6)*100).toStringAsFixed(0)+"%", textScaleFactor: 1.5,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: new AlwaysStoppedAnimation<Color>(Constants.primaryColor),
                value: (index+1)/6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
