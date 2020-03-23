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
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        pageButton(
          AppLocalizations.of(context).translate("infoForEveryone"),
          () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        pageButton(
            AppLocalizations.of(context).translate("infoForParents"),
            () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => InfoForParents()))),
        Spacer(flex: 4)
      ],
    ));
  }
}
