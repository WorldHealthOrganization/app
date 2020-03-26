import 'package:flutter/material.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:flutter/rendering.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class CarouselSlide extends StatelessWidget {
  final Widget titleWidget;
  final String message;
  final BuildContext context;

  const CarouselSlide(this.context, {this.titleWidget, this.message = ''});

  @override
  Widget build(BuildContext context) {
    final double scale = contentScale(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Spacer(flex: 1),
            titleWidget == null
                ? Container(height: 0)
                : Container(height: screenHeight * 0.4, child: titleWidget ?? Container()),
            const Spacer(flex: 1),
            Text(
              message,
              textScaleFactor: scale * 1.5,
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;

  CarouselView(this.items);

  final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (int i) => pageIndexNotifier.value = i,
            children: items,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: pageViewIndicator(context),
            ),
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

  Widget pageViewIndicator(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: PageViewIndicator(
              pageIndexNotifier: pageIndexNotifier,
              length: items.length,
              normalBuilder: (AnimationController animationController, int index) {
                return Circle(
                  size: 8.0,
                  color: Colors.grey,
                );
              },
              highlightedBuilder: (AnimationController animationController, int index) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animationController,
                    curve: Curves.ease,
                  ),
                  child: Circle(
                    size: 10.0,
                    color: Constants.primaryColor,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class EmojiHeader extends StatelessWidget {
  const EmojiHeader(this.emoji);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        emoji,
        textScaleFactor: 6,
      ),
    );
  }
}
