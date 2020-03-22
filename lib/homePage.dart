import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container pageButton(String title, Function onPressed) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          padding: EdgeInsets.all(30),
          onPressed: () => Share.share(
              'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu'),
          color: Constants.primaryColor,
          child: Text(
            title,
            textScaleFactor: 2,
          ),
        ),
      );
    }
    return PageScaffold(Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(30),
            onPressed: () {},
            color: Constants.primaryColor,
            child: Text(
              AppLocalizations.of(context).translate("protectYourself"),
              textScaleFactor: 2,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(30),
            onPressed: () {},
            color: Constants.primaryColor,
            child: Text(
              AppLocalizations.of(context).translate("checkYourHealth"),
              textScaleFactor: 2,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(30),
            onPressed: () {},
            color: Constants.primaryColor,
            child: Text(
              AppLocalizations.of(context).translate("localMaps"),
              textScaleFactor: 2,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            padding: EdgeInsets.all(30),
            onPressed: () => Share.share(
                'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu'),
            color: Constants.primaryColor,
            child: Text(
              AppLocalizations.of(context).translate("shareTheApp"),
              textScaleFactor: 2,
            ),
          ),
        ),
        pageButton(AppLocalizations.of(context).translate("shareTheApp"), ()=>Share.share(
                'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu'),)
      ],
    ));
    
  }
}
