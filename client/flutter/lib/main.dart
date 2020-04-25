import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/pages/main_pages/app_tab_router.dart';
import 'package:who_app/pages/onboarding/onboarding_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:who_app/api/notifications.dart';

import './constants.dart';
import 'generated/l10n.dart';

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

    _notifications.configure();
    _notifications.updateFirebaseToken();
  }

  // TODO: Issue #902 This is not essential for basic operation but we should implement
  // Fires if notification settings change.
  // Modify user opt-in if they do.
  // _firebaseMessaging.onIosSettingsRegistered
  //     .listen((IosNotificationSettings settings) {
  // });

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "WHO COVID-19",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      // FIXME Issue #1012 - disabled supported languages for P0
      //supportedLocales: S.delegate.supportedLocales,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Constants.primaryColor,
      ),
      home: Directionality(
        child: widget.showOnboarding
            ? OnboardingPage(analytics)
            : AppTabRouter(analytics),
        textDirection: GlobalWidgetsLocalizations(
          Locale(Intl.getCurrentLocale()),
        ).textDirection,
      ),
    );
  }
}
