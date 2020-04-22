import 'package:who_app/components/carousel/carousel_slide.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;

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
                colors: <Color>[Colors.white, Colors.white, Colors.transparent],
                stops: [0.0, 0.5, 0.6]).createShader(bounds);
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => pageController.page > 0
                      ? goToPreviousPage()
                      : goToLastPage(),
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: _buildPageViewIndicator(context)),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
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

  Future<void> goToLastPage() =>
      pageController.animateToPage(this.items.length - 1,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  Future<void> goToFirstPage() => pageController.animateToPage(0,
      duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

  Future<void> goToNextPage() => pageController.nextPage(
      duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

  Future<void> goToPreviousPage() => pageController.previousPage(
      duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

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
                    color: Constants.primaryDark.withOpacity(.75),
                  ),
                  highlightedBuilder: (animationController, index) =>
                      ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animationController,
                      curve: Curves.ease,
                    ),
                    child: Circle(
                      size: 28.0,
                      color: Constants.primaryDark,
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
