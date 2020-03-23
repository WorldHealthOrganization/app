import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/carouselPage.dart';

class InfoForParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide("assets/washHands.png", AppLocalizations.of(context).translate("childStress"), context),
      CarouselSlide("assets/cough.png", AppLocalizations.of(context).translate("childLove"), context),
      CarouselSlide("assets/cough.png", AppLocalizations.of(context).translate("childDistance"), context),
      CarouselSlide("assets/washHands.png", AppLocalizations.of(context).translate("childRoutines"), context),
      CarouselSlide("assets/distance.png", AppLocalizations.of(context).translate("childFacts"), context),
    ]);
  }
}