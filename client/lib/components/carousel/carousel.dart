import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:who_app/components/carousel/carousel_slide.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  CarouselView({required this.items});

  final pageIndexNotifier = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  Widget _animatedVisibility({required Widget child, required bool visible}) {
    return ExcludeSemantics(
      excluding: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: IgnorePointer(ignoring: !visible, child: child),
      ),
    );
  }

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
            children: items,
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SafeArea(
            child: ValueListenableBuilder(
              valueListenable: pageIndexNotifier,
              // Anything not effected by the value of the notifier
              builder: (context, dynamic index, _) {
                final isFirstPage = index == 0;
                final isLastPage = index + 1 == items.length;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _animatedVisibility(
                      visible: !isFirstPage,
                      child: CupertinoButton(
                        child: Icon(CupertinoIcons.back),
                        onPressed: goToPreviousPage,
                      ),
                    ),
                    _animatedVisibility(
                      visible: !isLastPage,
                      child: CupertinoButton(
                        child: Icon(CupertinoIcons.forward),
                        onPressed: goToNextPage,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> goToLastPage() {
    analytics.logEvent(name: 'CarouselLastPage');
    return pageController.animateToPage(items.length - 1,
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
}
