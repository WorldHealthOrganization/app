import 'dart:io';

import 'package:WHOFlutter/localization/localization.dart';
import 'package:WHOFlutter/pageScaffold.dart';
import 'package:WHOFlutter/pages/protectYourself.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './constants.dart';
import 'package:share/share.dart';

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
            () {
          List actions = [
            {
              "message": "Information for Parents",
              "onPressed": () {
                //Go to parents page
              }
            },
            {
              "message": "Information for Everyone",
              "onPressed": () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => ProtectYourself(),
                  ))
            },
          ];

          Platform.isIOS
              ? showCupertinoModalPopup(
                  context: context,
                  builder: (c) => CupertinoActionSheet(
                        cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel")),
                        actions: List<CupertinoActionSheetAction>.generate(
                            actions.length,
                            (index) => CupertinoActionSheetAction(
                                onPressed: actions[index]["onPressed"],
                                child: Text(actions[index]["message"]))),
                      ))
              : showModalBottomSheet(
                  context: context,
                  builder: (c) => BottomSheet(
                        onClosing: null,
                        builder: (c) => Column(
                          children: List<Widget>.generate(
                              actions.length,
                              (index) => ListTile(
                                    title: Text(actions[index]["message"]),
                                    onTap: actions[index]["onPressed"],
                                  )),
                        ),
                      ));
        }),
        /*
        pageButton(AppLocalizations.of(context).translate("localMaps"), () {}),
        */
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
