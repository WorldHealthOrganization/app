import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:WHOFlutter/pages/healthCheck/healthCheck.dart';
import 'package:WHOFlutter/protectYourself.dart';
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
          onPressed: onPressed,
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
        
        pageButton(
            AppLocalizations.of(context).translate("protectYourself"), ()=>Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c)=>ProtectYourself()
              )
            )),
        pageButton(
            AppLocalizations.of(context).translate("checkYourHealth"), () {}),
        pageButton(AppLocalizations.of(context).translate("localMaps"), () {}),
        pageButton(
          AppLocalizations.of(context).translate("shareTheApp"),
          () => Share.share(
              'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu'),
        )
      ],
    ));
  }
}
