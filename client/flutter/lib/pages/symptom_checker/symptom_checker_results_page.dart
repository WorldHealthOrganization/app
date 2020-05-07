import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class SymptomCheckerResultsPage extends StatelessWidget {
  final int risk;

  const SymptomCheckerResultsPage({Key key, @required this.risk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      disableBackButton: true,
      showHeader: true,
      title: "Check-Up",
      body: <Widget>[_buildBody(context)],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        SafeArea(child: headingWidget(context)),
        bodyWidget(context),
        submitWidget(context),
      ]));

  Widget headingWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64, left: 24, right: 24),
      child: Column(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.solidCheckCircle,
            color: risk < 2 ? Colors.green : Constants.primaryColor,
            size: 48,
          ),
          SizedBox(
            height: 32,
          ),
          ThemedText(
            risk < 2 ? "Thanks for recording!" : "Your symptoms were recorded",
            variant: TypographyVariant.h3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static const List<String> bodies = <String>[
    "We're glad you're feeling well! Regularly tracking your symptoms will help medical professionals give you better advice, if you start to feel sick.",
    "A medical professional can help you figure out what to do next. Regularly tracking your symptoms will help them give you better advice.",
    "Some of the symptoms you're experiencing might be caused by COVID-19. They also might be caused by something else. A medical professional can help you figure out what to do next.\n\nFor guidance on whether to get tested, check guidance from your health agency.\n\nRegularly tracking your symptoms will help medical professionals give you better advice.",
  ];

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          ThemedText(
            bodies[risk],
            variant: TypographyVariant.body,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget submitWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 24,
        right: 24,
        bottom: 48,
      ),
      child: PageButton(
        Constants.primaryColor,
        "My Dashboard",
        () {
          return Navigator.of(context, rootNavigator: true).pop();
        },
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalPadding: 12,
        borderRadius: 500,
        titleStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}