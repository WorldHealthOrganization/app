import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

class InfoForParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide(context,
          titleWidget: Image.asset("assets/washhands.png"),
          message: S.of(context).childStress),
      CarouselSlide(context,
          titleWidget: Image.asset("assets/cough.png"),
          message: S.of(context).childLove),
      CarouselSlide(context,
          titleWidget: Image.asset("assets/cough.png"),
          message: S.of(context).childDistance),
      CarouselSlide(context,
          titleWidget: Image.asset("assets/washhands.png"),
          message: S.of(context).childRoutines),
      CarouselSlide(
        context,
        titleWidget: Image.asset("assets/socialdistance.png"),
        message: S.of(context).childFacts,
      ),
    ]);
  }
}
