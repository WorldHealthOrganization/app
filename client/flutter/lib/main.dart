import 'package:flutter/material.dart';
import './home_page.dart';
import './constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WHO",
      localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      S.delegate
    ], 
    supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.backgroundColor,
        primaryColor: Constants.primaryColor,
        accentColor: Constants.textColor,
        buttonTheme: ButtonThemeData(buttonColor: Constants.primaryColor, textTheme: ButtonTextTheme.accent),
      ),
      home: HomePage(),
    );
  }
}
