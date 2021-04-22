import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_html/style.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

class CarouselSlide extends StatefulWidget {
  final SvgPicture? graphic;
  final String? title;
  final String? body;
  final int index;
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  CarouselSlide(
      {required Key key,
      required this.title,
      required this.body,
      required this.index,
      this.graphic})
      : super(key: key);

  @override
  _CarouselSlideState createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
  bool _showDetails = false;

  @override
  void initState() {
    widget.analytics.logEvent(
        name: 'CarouselSlideLoad', parameters: {'index': widget.index});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final titleStyle = TextStyle(
      color: Constants.primaryDarkColor,
      fontSize: 36.0 * screenSize.width.clamp(275, 550) / 550,
      fontWeight: FontWeight.w600,
      letterSpacing: -.5,
    );
    final bodyStyle = TextStyle(
      color: Constants.textColor,
      fontSize: 16.0,
      height: 1.4,
    );

    Map<String, Style> htmlTextStyle(TextStyle baseStyle) => {
          '*': Style.fromTextStyle(baseStyle),
          'em': Style.fromTextStyle(
            baseStyle.merge(
              TextStyle(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          'b': Style.fromTextStyle(
            baseStyle.merge(
              TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          'u': Style.fromTextStyle(
            baseStyle.merge(
              TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        };
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
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
              data: widget.title!,
              style: htmlTextStyle(titleStyle),
            ),
            SizedBox(height: 16),
            if (!_showDetails)
              _buildLearnMore(titleStyle)
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: Html(
                  data: widget.body!,
                  style: htmlTextStyle(bodyStyle),
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
      onTap: () {
        widget.analytics.logEvent(
            name: 'CarouselSlideLearnMore',
            parameters: {'index': widget.index});
        setState(() {
          _showDetails = true;
        });
      },
      child: Row(
        children: <Widget>[
          SizedBox(width: 4.0),
          Text('Learn More', style: titleStyle.copyWith(fontSize: 18.0)),
          SizedBox(width: 6.0),
          Icon(Icons.lightbulb_outline, color: titleStyle.color)
        ],
      ),
    );
  }
}
