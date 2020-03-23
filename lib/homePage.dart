import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageButton.dart';
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
    return PageScaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Spacer(flex: 1),
        PageButton(
            title: AppLocalizations.of(context).translate("protectYourself"),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => ProtectYourself()))),
        PageButton(
            title: AppLocalizations.of(context).translate("checkYourHealth"),
            onPressed: () {}),
        PageButton(
            title: AppLocalizations.of(context).translate("feelingDistressed"),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => FeelingDistressedPage()))),
        PageButton(
            title: AppLocalizations.of(context).translate("shareTheApp"),
            onPressed: () => Share.share(
                'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu')),
        Spacer(flex: 3)
      ],
    ));
  }
}

