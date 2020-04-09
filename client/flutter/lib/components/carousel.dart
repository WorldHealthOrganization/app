import 'package:WHOFlutter/components/page_scaffold/page_header.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:html/dom.dart' as dom;

class CarouselView extends StatelessWidget {
  final List<CarouselSlide> items;

  CarouselView({@required this.items});

  final pageIndexNotifier = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          controller: pageController,
          onPageChanged: (i) => pageIndexNotifier.value = i,
          children: this.items,
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SafeArea(
            child: Container(
                padding: EdgeInsets.only(bottom: 16),
                child: _buildPageViewIndicator(context)),
          ),
        ),
      ],
    );
  }

  Widget _buildPageViewIndicator(BuildContext context) {
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

class CarouselSlide extends StatelessWidget {
  final String title;
  final String body;
  final SvgPicture graphic;

  CarouselSlide({@required this.title, @required this.body, this.graphic});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var defaultStyle = TextStyle(
      color: PageHeader.textColor,
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              height: screenSize.height * 0.30,
              child: graphic),
          Html(
            data: body,
            defaultTextStyle: defaultStyle,
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "b":
                    return baseStyle
                        .merge(TextStyle(decoration: TextDecoration.underline));
                }
              }
              return baseStyle.merge(defaultStyle);
            },
          ),
        ],
      ),
    );
  }
}
