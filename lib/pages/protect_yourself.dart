import 'package:WHOFlutter/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

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
