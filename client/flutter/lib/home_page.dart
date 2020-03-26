import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/page_button.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(flex: 1),
        PageButton(
          title: S.of(context).protectYourself,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext c) => ProtectYourself(),
            ),
          ),
        ),
        PageButton(
          title: S.of(context).whoMythBusters,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext c) => WhoMythBusters(),
            ),
          ),
        ),
        PageButton(
          title: S.of(context).travelAdvice,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext c) => TravelAdvice(),
            ),
          ),
        ),
        PageButton(
            title: S.of(context).shareTheApp,
            lightColor: true,
            onPressed: () => Share.share(
                'Check out the official COVID-19 Guide App https://www.who.int/covid-19-app')),
        PageButton(
            title: S.of(context).aboutTheApp,
            lightColor: true,
            onPressed: () => showAboutDialog(
                context: context,
                applicationLegalese: 'The official World Health Organization COVID-19 App.')),
        const Spacer(flex: 3)
      ],
    ));
  }
}
