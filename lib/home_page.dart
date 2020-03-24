import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/page_button.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:WHOFlutter/pages/feeling_distressed.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import './pages/feeling_distressed.dart';

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
            title: S.of(context).protectYourself,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => ProtectYourself()))),
        PageButton(
            title:  S.of(context).checkYourHealth,
            onPressed: () {}),
        PageButton(
            title:  S.of(context).feelingDistressed,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => FeelingDistressedPage()))),
        PageButton(
            title:  S.of(context).shareTheApp,
            onPressed: () => Share.share(
                'Check out the official COVID-19 GUIDE App https://preview.whoapp.org/menu')),
        Spacer(flex: 3)
      ],
    ));
  }
}

