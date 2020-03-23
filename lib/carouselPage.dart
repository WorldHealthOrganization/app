import 'package:flutter/material.dart';
import 'pageScaffold.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

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
        child: ListView(
          children: <Widget>[
            Image(
              image: AssetImage(imgSrc),
              // width: width,
            ),
            Text(
              message,
              textScaleFactor: 1.7,
              textAlign: TextAlign.center,
            ),
            Container(height: 60,)
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
