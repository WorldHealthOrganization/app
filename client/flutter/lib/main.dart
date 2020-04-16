import 'dart:async';

import 'package:WHOFlutter/api/notifications.dart';
import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/pages/onboarding/onboarding_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import './constants.dart';
import 'generated/l10n.dart';
import 'pages/home_page.dart';

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

  final bool onboardingComplete =
      await UserPreferences().getOnboardingCompleted();

  if (onboardingComplete) {
  // Set `enableInDevMode` to true to see reports while in debug mode
    // This is only to be used for confirming that reports are being
    // submitted as expected. It is not intended to be used for everyday
    // development.
    Crashlytics.instance.enableInDevMode = false;

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;

    await runZoned<Future<void>>(
      () async {
        runApp(MyApp(showOnboarding: !onboardingComplete));
      },
      onError: Crashlytics.instance.recordError,
    );
  } else {
    runApp(MyApp(showOnboarding: false));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key, @required this.showOnboarding}) : super(key: key);
  final bool showOnboarding;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState(analytics, observer);
}

class _MyAppState extends State<MyApp> {
  final Notifications _notifications = Notifications();

  _MyAppState(this.analytics, this.observer);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _registerLicenses();

    // onMessage: Fires when app is foreground
    // onLaunch: Fires when user taps and app is in background.
    // onResume: Fires when user taps and app is terminated
    _notifications.configure();
    _notifications.updateFirebaseToken();
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

  // TODO: Issue #902 This is not essential for basic operation but we should implement
  // Fires if notification settings change.
  // Modify user opt-in if they do.
  // _firebaseMessaging.onIosSettingsRegistered
  //     .listen((IosNotificationSettings settings) {
  // });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WHO COVID-19",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      // FIXME Issue #1012 - disabled supported languages for P0
      //supportedLocales: S.delegate.supportedLocales,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.backgroundColor,
        primaryColor: Constants.primaryColor,
        accentColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        dividerColor: Color(0xffC9CDD6),
        buttonTheme: ButtonThemeData(
          buttonColor: Constants.primaryColor,
          textTheme: ButtonTextTheme.accent,
        ),
      ),
      home: Directionality(
        child: widget.showOnboarding
            ? OnboardingPage(analytics)
            : HomePage(analytics),
        textDirection: GlobalWidgetsLocalizations(
          Locale(Intl.getCurrentLocale()),
        ).textDirection,
      ),
    );
  }
}
