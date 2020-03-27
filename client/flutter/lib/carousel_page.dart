import 'package:flutter/material.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class CarouselSlide extends StatelessWidget {
  final Widget titleWidget;
  final String message;

  CarouselSlide({this.titleWidget, this.message = ""});

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

class CarouselView extends StatefulWidget {
  final List<CarouselSlide> items;

  CarouselView(this.items);

  @override
  _CarouselViewState createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  final _kPageTransitionDuration = const Duration(milliseconds: 300);

  final pageIndexNotifier = ValueNotifier<int>(0);
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            onPageChanged: (i) => pageIndexNotifier.value = i,
            children: this.widget.items,
          ),
          ValueListenableBuilder(
            valueListenable: pageIndexNotifier,
            builder: (BuildContext context, int page, Widget child) {
              return Visibility(
                visible: page > 0,
                child: child,
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.chevron_left, size: 36),
                onPressed: () {
                  pageController.previousPage(
                    duration: _kPageTransitionDuration,
                    curve: Curves.fastOutSlowIn
                  );
                },
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: pageIndexNotifier,
            builder: (BuildContext context, int page, Widget child) {
              return Visibility(
                visible: page < widget.items.length - 1,
                child: child,
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.chevron_right, size: 36),
                onPressed: () {
                  pageController.nextPage(
                    duration: _kPageTransitionDuration,
                    curve: Curves.fastOutSlowIn
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: pageViewIndicator(context)),
          ),
          Align(
              alignment: FractionalOffset.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.grey,
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
              length: this.widget.items.length,
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
