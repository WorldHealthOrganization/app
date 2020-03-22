import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';

int currentPageValue;

class ProtectYourself extends StatefulWidget {
  @override
  _ProtectYourselfState createState() => _ProtectYourselfState();
}

class _ProtectYourselfState extends State<ProtectYourself> {
  @override
  void initState() {
    currentPageValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(Column(children: <Widget>[
      PageView(
        onPageChanged: (int page) {
          getChangedPageAndMoveBar(page);
        },
        children: <Widget>[
          slide("assets/washHands.png",
              AppLocalizations.of(context).translate("washHands"), context),
          slide(
              "assets/cough.png",
              AppLocalizations.of(context).translate("cougningAndSneezing"),
              context),
          slide(
              "assets/cough.png",
              AppLocalizations.of(context).translate("throwAwayTissue"),
              context),
          slide(
              "assets/washHands.png",
              AppLocalizations.of(context).translate("washHandsFrequently"),
              context),
          slide(
              "assets/distance.png",
              AppLocalizations.of(context).translate("socialDistancing"),
              context),
          slide(
              "assets/distance.png",
              AppLocalizations.of(context).translate("seekMedicalCare"),
              context),
        ],
      ),
      Container(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 6; i++)
              if (i == currentPageValue) ...[circleBar(true, context)] else
                circleBar(false, context),
          ],
        ),
      ),
    ]));
  }
}

Widget slide(String imgSrc, String message, BuildContext context) {
  double width = MediaQuery.of(context).size.width * 9 / 10;
  double height = MediaQuery.of(context).size.height / 2;

  return Container(
    child: Card(
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(imgSrc),
            width: width,
            height: height,
          ),
          Text(
            message,
            textScaleFactor: 1.7,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

Widget circleBar(bool isActive, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
  );
}

void getChangedPageAndMoveBar(int page) {
  currentPageValue = page;
  setState() {}
  ;
}
