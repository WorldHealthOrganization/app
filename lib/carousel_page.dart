import 'package:flutter/material.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class CarouselSlide extends StatelessWidget {
  CarouselSlide(this.imgSrc, this.message, this.context);

  final String imgSrc;
  final String message;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(flex: 1),
            Image(
              image: AssetImage(imgSrc),
              // width: width,
            ),
            Spacer(flex: 1),
            Text(
              message,
              textScaleFactor: 1.7,
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;

  CarouselView(this.items);

  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (i) => pageIndexNotifier.value = i,
            children: this.items,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: pageViewIndicator()),
          ),
          Align(
              alignment: FractionalOffset.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              )),
        ],
      ),
      bodyPadding: EdgeInsets.zero,
    );
  }

  PageViewIndicator pageViewIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: this.items.length,
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
