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
            child: Container(
                padding: EdgeInsets.only(bottom: 8),
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
          child: FittedBox(
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

class CarouselSlide extends StatefulWidget {
  final SvgPicture graphic;
  final String title;
  final String body;

  CarouselSlide(
      {@required Key key,
      @required this.title,
      @required this.body,
      this.graphic})
      : super(key: key);

  @override
  _CarouselSlideState createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    var titleStyle = TextStyle(
      color: PageHeader.textColor,
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
    );
    var bodyStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    );

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                alignment: Alignment.centerRight,
                height: _showDetails ? 0.0 : screenSize.height * 0.25,
                child: widget.graphic ?? Container()),
            Html(
              data: widget.title,
              defaultTextStyle: titleStyle,
              customTextStyle: _titleHtmlStyle,
            ),
            SizedBox(height: 16),
            if (!_showDetails)
              _buildLearnMore(titleStyle)
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: Html(
                  data: widget.body,
                  defaultTextStyle: bodyStyle,
                  customTextStyle: _titleHtmlStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildLearnMore(TextStyle titleStyle) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: <Widget>[
            Text("Learn More", style: titleStyle.copyWith(fontSize: 18.0)),
            SizedBox(width: 6.0),
            Icon(Icons.lightbulb_outline, color: titleStyle.color)
          ],
        ),
        onTap: () {
          setState(() {
            _showDetails = true;
          });
        });
  }

  TextStyle _titleHtmlStyle(dom.Node node, TextStyle baseStyle) {
    if (node is dom.Element) {
      switch (node.localName) {
        case "em":
          return baseStyle.merge(TextStyle(
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.underline));
        case "b":
          return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold));
      }
    }
    return baseStyle;
  }
}
