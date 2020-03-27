import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import './constants.dart';
import './home_page.dart';
import 'generated/l10n.dart';

void main() {
  /// Since macOS is not yet a supported platform in TargetPlatform we need
  /// to override the default platform to one that is.
  debugDefaultTargetPlatformOverride ??= TargetPlatform.iOS;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WHO",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: Platform.isMacOS ? [Locale('en', '')] : S.delegate.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.backgroundColor,
        primaryColor: Constants.primaryColor,
        accentColor: Constants.textColor,
        buttonTheme: ButtonThemeData(
          buttonColor: Constants.primaryColor,
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      home: Directionality(
          child: HomePage(), textDirection: GlobalWidgetsLocalizations(Locale(Intl.getCurrentLocale())).textDirection),
    );
  }
}
