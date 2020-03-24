import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

class InfoForParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide("assets/washHands.png", S.of(context).childStress, context),
      CarouselSlide("assets/cough.png", S.of(context).childLove, context),
      CarouselSlide("assets/cough.png", S.of(context).childDistance, context),
      CarouselSlide("assets/washHands.png", S.of(context).childRoutines, context),
      CarouselSlide("assets/distance.png", S.of(context).childFacts, context),
    ]);
  }
}