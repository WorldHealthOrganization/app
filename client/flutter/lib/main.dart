import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'pages/home_page.dart';
import './constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

PackageInfo _packageInfo;
PackageInfo get packageInfo => _packageInfo;

void main() async {
  // Asyncronous code that runs before the splash screen is hidden goes before
  // runApp()
  if (!kIsWeb) {
    // Initialises binding so we can use the framework before calling runApp
    WidgetsFlutterBinding.ensureInitialized();
    _packageInfo = await PackageInfo.fromPlatform();
  }

  runApp(MyApp());
}

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
    _registerLicenses();
  }

  Future<LicenseEntry> _loadLicense() async {
    final licenseText = await rootBundle.loadString('assets/REPO_LICENSE');
    return LicenseEntryWithLineBreaks(
        ["https://github.com/WorldHealthOrganization/app"], licenseText);
  }

  Future<LicenseEntry> _load3pLicense() async {
    final licenseText =
        await rootBundle.loadString('assets/THIRD_PARTY_LICENSE');
    return LicenseEntryWithLineBreaks([
      "https://github.com/WorldHealthOrganization/app - THIRD_PARTY_LICENSE"
    ], licenseText);
  }

  _registerLicenses() {
    LicenseRegistry.addLicense(() {
      return Stream<LicenseEntry>.fromFutures(<Future<LicenseEntry>>[
        _loadLicense(),
        _load3pLicense(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WHO COVID-19",
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
