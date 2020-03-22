import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50),
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            onPressed: () {},
            color: Constants.primaryColor,
            child: Text(
              AppLocalizations.of(context).translate("protectYourself"),
              textScaleFactor: 2,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            onPressed: () {},
            color: Constants.primaryColor,
            child: Text(
              'Check Your Health',
              textScaleFactor: 2,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            onPressed: () {},
            color: Constants.primaryColor,
            child: Text(
              'Local Maps',
              textScaleFactor: 2,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            onPressed: () {
                Share.share('Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu');
              },
            color: Constants.primaryColor,
            child: Text(
              'Share the App',
              textScaleFactor: 2,
            ),
          ),
        )
      ],
    ));
  }
}
