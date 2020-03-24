import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide("assets/washHands.png", S.of(context).washHands, context),
      CarouselSlide(
          "assets/cough.png", S.of(context).cougningAndSneezing, context),
      CarouselSlide("assets/cough.png", S.of(context).throwAwayTissue, context),
      CarouselSlide(
          "assets/washHands.png", S.of(context).washHandsFrequently, context),
      CarouselSlide(
          "assets/distance.png", S.of(context).socialDistancing, context),
      CarouselSlide(
          "assets/distance.png", S.of(context).seekMedicalCare, context),
    ]);
  }
}
