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
        floorWidget(context),
      ]));

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64, left: 24, right: 24),
      child: Column(
        children: <Widget>[
          Text(
            'Your results',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          risk < 2
              ? Text(
                  'Unlikely',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Constants.primaryColor,
                      fontSize: 48),
                )
              : Text(
                  'Unlikely',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Constants.primaryColor,
                      fontSize: 48),
                ),
        ],
      ),
    );
  }

  Widget videoWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32, left: 48, right: 48),
      child: PageButton(
        Constants.primaryColor,
        "Watch Video",
        () {
          // Go to video
        },
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalPadding: 0,
        borderRadius: 50,
        titleStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget floorWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 56),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ),
        color: Constants.primaryColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(top: 47, bottom: 42, left: 34, right: 18),
          child: Column(
            children: <Widget>[
              risk < 2
                  ? Text(
                      'It is unlikely you have contracted the Coronavirus.',
                      style: TextStyle(
                          color: Constants.backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'It is likely you have contracted the Coronavirus.',
                      style: TextStyle(
                          color: Constants.backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
              SizedBox(height: 12,),
              Text(
                'Stay aware of the latest information on the COVID-19 outbreak, available on the WHO website and through your national and local public health authority. Most people who become infected experience mild illness and recover, but it can be more severe for others.',
                style: TextStyle(
                  color: Constants.backgroundColor,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
