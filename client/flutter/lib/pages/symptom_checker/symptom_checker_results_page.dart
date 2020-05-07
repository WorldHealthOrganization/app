import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class SymptomCheckerResultsPage extends StatelessWidget {
  final int risk;

  const SymptomCheckerResultsPage({Key key, @required this.risk})
      : super(key: key);

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
        SafeArea(child: bodyWidget(context)),
        videoWidget(context),
      ]));

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64, left: 24, right: 24),
      child: Column(
        children: <Widget>[
          Text(
            'Your results',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          risk < 2
              ? Text(
                  'Unlikely',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Constants.primaryColor,
                      fontSize: 42),
                )
              : Text(
                  'Unlikely',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Constants.primaryColor,
                      fontSize: 42),
                ),
        ],
      ),
    );
  }

  Widget videoWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 24,
        right: 24,
        bottom: 48,
      ),
      child: PageButton(
        Constants.primaryColor,
        "Watch Video",
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

  Widget floorWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
