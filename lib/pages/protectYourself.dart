import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide("assets/washHands.png",
          AppLocalizations.of(context).translate("washHands"), context),
      CarouselSlide(
          "assets/cough.png",
          AppLocalizations.of(context).translate("cougningAndSneezing"),
          context),
      CarouselSlide("assets/cough.png",
          AppLocalizations.of(context).translate("throwAwayTissue"), context),
      CarouselSlide(
          "assets/washHands.png",
          AppLocalizations.of(context).translate("washHandsFrequently"),
          context),
      CarouselSlide("assets/distance.png",
          AppLocalizations.of(context).translate("socialDistancing"), context),
      CarouselSlide("assets/distance.png",
          AppLocalizations.of(context).translate("seekMedicalCare"), context),
    ]);
  }
}

class CarouselSlide extends StatelessWidget {
  CarouselSlide(this.imgSrc, this.message, this.context);
  final String imgSrc;
  final String message;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}

class CarouselView extends StatelessWidget {
  List<CarouselSlide> items = [];
  CarouselView(this.items);

  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (i)=>pageIndexNotifier.value = i,
            children: this.items,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: pageViewIndicator()),
          )
        ],
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
