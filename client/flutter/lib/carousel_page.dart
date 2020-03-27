import 'package:flutter/material.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class CarouselSlide extends StatelessWidget {
  final Widget titleWidget;
  final String message;
  final BuildContext context;

  CarouselSlide(this.context, {this.titleWidget, this.message = ""});

  @override
  Widget build(BuildContext context) {
    double scale = contentScale(context);
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(24),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(flex: 1),
            this.titleWidget == null
                ? Container(
                    height: 0,
                  )
                : Container(
                    height: screenHeight * 0.4,
                    child: this.titleWidget ?? Container()),
            Spacer(flex: 1),
            Text(
              this.message,
              textScaleFactor: scale * 1.5,
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

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            onPageChanged: (i) => pageIndexNotifier.value = i,
            children: this.items,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: pageViewIndicator(context)),
          ),
          GestureDetector(
              onTap: () => pageController.page == this.items.length - 1
                  ? null
                  : pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic)),
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

  Widget pageViewIndicator(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: PageViewIndicator(
              pageIndexNotifier: pageIndexNotifier,
              length: this.items.length,
              normalBuilder: (animationController, index) => Circle(
                size: 8.0,
                color: Colors.grey,
              ),
              highlightedBuilder: (animationController, index) =>
                  ScaleTransition(
                scale: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.ease,
                ),
                child: Circle(
                  size: 10.0,
                  color: Constants.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EmojiHeader extends StatelessWidget {
  EmojiHeader(this.emoji);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.emoji,
        textScaleFactor: 6,
      ),
    );
  }
}
