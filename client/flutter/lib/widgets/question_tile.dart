import 'dart:math';
import 'package:WHOFlutter/models/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class QuestionTile extends StatefulWidget {
  const QuestionTile({
    @required this.question,
  });

  final Question question;

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile>
    with TickerProviderStateMixin {
  AnimationController rotationController;

  Color titleColor;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
        lowerBound: 0,
        upperBound: pi / 4);

    titleColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: <Widget>[
        Divider(
          height: 1,
          thickness: 1,
        ),
        ExpansionTile(
          onExpansionChanged: (expanded) {
            if (expanded) {
              rotationController.forward();
            } else {
              rotationController.reverse();
            }
          },
          key: PageStorageKey<String>(widget.question.title),
          trailing: AnimatedBuilder(
            animation: rotationController,
            child: Icon(Icons.add_circle_outline, color: Color(0xff3C4245)),
            builder: (context, child) {
              return Transform.rotate(
                angle: rotationController.value,
                child: child,
              );
            },
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Html(
              data: widget.question.title,
              defaultTextStyle: _titleStyle.copyWith(
                fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              ),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 32, bottom: 32),
              child: html(widget.question.body),
            )
          ],
        ),
      ]),
    );
  }

  // flutter_html supports a subset of html: https://pub.dev/packages/flutter_html
  Widget html(String html) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Html(
      data: html,
      defaultTextStyle: TextStyle(fontSize: 16 * textScaleFactor),
      linkStyle: const TextStyle(
        color: Colors.deepPurple,
      ),
      onLinkTap: (url) {
        launch(url, forceSafariVC: false);
      },
      onImageTap: (src) {},
      // This is our css :)
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "h2":
              return baseStyle.merge(TextStyle(
                  fontSize: 20,
                  color: Color(0xff3C4245),
                  fontWeight: FontWeight.w500));
            case "b":
              return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold));
          }
        }
        return baseStyle.merge(_bodyStyle);
      },
    );
  }

  final _bodyStyle =
      TextStyle(color: Color(0xff3C4245), fontWeight: FontWeight.w400);

  final _titleStyle =
      TextStyle(color: Color(0xff3C4245), fontWeight: FontWeight.w700);
}
