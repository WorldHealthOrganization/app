import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

class InfoForParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide(Image.asset("assets/washHands.png"),
          S.of(context).childStress, context),
      CarouselSlide(
          Image.asset("assets/cough.png"), S.of(context).childLove, context),
      CarouselSlide(Image.asset("assets/cough.png"),
          S.of(context).childDistance, context),
      CarouselSlide(Image.asset("assets/washHands.png"),
          S.of(context).childRoutines, context),
      CarouselSlide(Image.asset("assets/socialdistance.png"),
          S.of(context).childFacts, context),
    ]);
  }
}
