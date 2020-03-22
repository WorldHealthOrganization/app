import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class ProtectYourself extends StatelessWidget {
  PageController pageController = new PageController();
  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Stack(
          children: <Widget>[
            PageView(
              controller: pageController,
              onPageChanged: (index) => pageIndexNotifier.value = index,
              children: <Widget>[
                slide(
                    "assets/washHands.png",
                    AppLocalizations.of(context).translate("washHands"),
                    context,
                    0),
                slide(
                    "assets/cough.png",
                    AppLocalizations.of(context)
                        .translate("cougningAndSneezing"),
                    context,
                    1),
                slide(
                    "assets/cough.png",
                    AppLocalizations.of(context).translate("throwAwayTissue"),
                    context,
                    2),
                slide(
                    "assets/washHands.png",
                    AppLocalizations.of(context)
                        .translate("washHandsFrequently"),
                    context,
                    3),
                slide(
                    "assets/distance.png",
                    AppLocalizations.of(context).translate("socialDistancing"),
                    context,
                    4),
                slide(
                    "assets/distance.png",
                    AppLocalizations.of(context).translate("seekMedicalCare"),
                    context,
                    5),
              ],
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(padding: EdgeInsets.only(bottom: 20),
              child: pageViewIndicator()),
            )
          ],
        ),
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
            // Expanded(
            //   child: Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: LinearProgressIndicator(
            //         backgroundColor: Colors.transparent,
            //         valueColor: new AlwaysStoppedAnimation<Color>(
            //             Constants.primaryColor),
            //         value: (index + 1) / 6,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  PageViewIndicator pageViewIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: 6,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 10.0,
          color: Constants.primaryColor,
        ),
      ),
    );
  }
}
