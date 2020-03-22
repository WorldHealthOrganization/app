import 'package:WHOFlutter/localization/localization.dart';
import 'package:flutter/material.dart';
import './homePage.dart';
import './constants.dart';
import './protectYourself.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      supportedLocales: [
        const Locale("en", "US"), // English, must be first
        const Locale("fr"), // French
        const Locale("ar"), // Arabic
        const Locale("zh"), // Chinese
        const Locale("ru"), // Russian
        const Locale("es"), //Spanish
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        backgroundColor: Constants.backgroundColor,
        primaryColor: Constants.primaryColor,
        accentColor: Constants.textColor,
        buttonTheme: ButtonThemeData(buttonColor: Constants.primaryColor, textTheme: ButtonTextTheme.accent),
      ),
      home: ProtectYourself(),
    );
  }
}
