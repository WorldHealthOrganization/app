import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:who_app/components/carousel/carousel_slide.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flutter/cupertino.dart';

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  CarouselView({@required this.items});

  final pageIndexNotifier = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
                begin: Alignment(0.0, 0.0),
                end: Alignment(0.0, 1.0),
                colors: <Color>[
                  CupertinoColors.white,
                  CupertinoColors.white,
                  Color(0xf).withOpacity(0)
                ],
                stops: [
                  0.0,
                  0.5,
                  0.6
                ]).createShader(bounds);
          },
          child: PageView(
            controller: pageController,
            onPageChanged: (i) => pageIndexNotifier.value = i,
            children: this.items,
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  child: Icon(CupertinoIcons.back),
                  onPressed: () => pageController.page > 0
                      ? goToPreviousPage()
                      : goToLastPage(),
                ),
                Container(child: _buildPageViewIndicator(context)),
                CupertinoButton(
                  child: Icon(CupertinoIcons.forward),
                  onPressed: () => pageController.page < this.items.length - 1
                      ? goToNextPage()
                      : goToFirstPage(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> goToLastPage() {
    analytics.logEvent(name: 'CarouselLastPage');
    return pageController.animateToPage(this.items.length - 1,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> goToFirstPage() {
    analytics.logEvent(name: 'CarouselFirstPage');
    return pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> goToNextPage() {
    analytics.logEvent(name: 'CarouselNextPage');
    return pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> goToPreviousPage() {
    analytics.logEvent(name: 'CarouselPreviousPage');
    return pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Widget _buildPageViewIndicator(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.5),
              child: FittedBox(
                child: PageViewIndicator(
                  pageIndexNotifier: pageIndexNotifier,
                  length: this.items.length,
                  normalBuilder: (animationController, index) => Circle(
                    size: 20.0,
                    color: Constants.neutralTextLightColor.withOpacity(0.2),
                  ),
                  highlightedBuilder: (animationController, index) =>
                      ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animationController,
                      curve: Curves.ease,
                    ),
                    child: Circle(
                      size: 24.0,
                      color: Constants.primaryDarkColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
