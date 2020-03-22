import 'dart:io';

import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:WHOFlutter/pages/protectYourself.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import 'package:share/share.dart';
import './pages/feelingDistressed.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(ListView(
      children: <Widget>[
        pageButton(
            AppLocalizations.of(context).translate("protectYourself"),
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => ProtectYourself()))),
        pageButton(
            AppLocalizations.of(context).translate("checkYourHealth"), () {}),
        pageButton(AppLocalizations.of(context).translate("feelingDistressed"),
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => FeelingDistressedPage()))
        ),
        pageButton(
          AppLocalizations.of(context).translate("shareTheApp"),
          () => Share.share(
              'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu'),
        )
      ],
    ));
  }
}

Container pageButton(String title, Function onPressed) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: FlatButton(
      padding: EdgeInsets.all(30),
      onPressed: onPressed,
      color: Constants.primaryColor,
      child: Text(
        title,
        textScaleFactor: 2,
      ),
    ),
  );
}
