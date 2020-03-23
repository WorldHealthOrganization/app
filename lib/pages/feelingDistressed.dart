import 'package:flutter/material.dart';
import 'package:WHOFlutter/localization/localization.dart';
import '../homePage.dart';
import '../pageScaffold.dart';
import './protectYourself.dart';
import './infoForParents.dart';

class FeelingDistressedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      ListView(
        children: <Widget>[
          pageButton(
            AppLocalizations.of(context).translate("infoForEveryone"),
            ()  => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => ProtectYourself())),),
          pageButton(
            AppLocalizations.of(context).translate("infoForParents"),
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => InfoForParents()))),
        ],
      )
    );
  }

}