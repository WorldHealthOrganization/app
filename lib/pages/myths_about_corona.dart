import 'package:WHOFlutter/carousel_page.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class MythsAboutCorona extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide(Image.asset("assets/washHands.png"), S.of(context).washHands, context),
      CarouselSlide(
          Image.asset("assets/cough.png"), S.of(context).cougningAndSneezing, context),
      CarouselSlide( Image.asset("assets/cough.png"), S.of(context).throwAwayTissue, context),
      CarouselSlide(
           Image.asset("assets/washHands.png"), S.of(context).washHandsFrequently, context),
      CarouselSlide(
           Image.asset("assets/distance.png"), S.of(context).socialDistancing, context),
      CarouselSlide(
           Image.asset("assets/distance.png"), S.of(context).seekMedicalCare, context),
    ]);
  }
}