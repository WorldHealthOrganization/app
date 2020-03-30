import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'pages/home_page.dart';
import './constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  _MyAppState createState() => _MyAppState(analytics, observer);
}

class _MyAppState extends State<MyApp> {
  _MyAppState(this.analytics, this.observer);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (!kAnalyticsAllowed) {
      _disableAnalytics();
    }
  }

  _disableAnalytics() async {
    await analytics.resetAnalyticsData();
    await analytics.setAnalyticsCollectionEnabled(false);
  }

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
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.backgroundColor,
        primaryColor: Constants.primaryColor,
        accentColor: Constants.textColor,
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
            buttonColor: Constants.primaryColor,
            textTheme: ButtonTextTheme.accent),
      ),
      home: Directionality(
          child: HomePage(analytics),
          textDirection:
              GlobalWidgetsLocalizations(Locale(Intl.getCurrentLocale()))
                  .textDirection),
    );
  }
}
