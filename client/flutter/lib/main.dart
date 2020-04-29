import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

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

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  // Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = _onFlutterError;

  await runZoned<Future<void>>(
    () async {
      runApp(MyApp(showOnboarding: !onboardingComplete));
    },
    onError: _onError,
  );
}

Future<void> _onFlutterError(FlutterErrorDetails details) async {
  if (await UserPreferences().getOnboardingCompleted()) {
    // Pass all uncaught errors from the framework to Crashlytics.
    await Crashlytics.instance.recordFlutterError(details);
  }
}

Future<void> _onError(Object error, StackTrace stack) async {
  if (await UserPreferences().getOnboardingCompleted()) {
    await Crashlytics.instance.recordError(error, stack);
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
    return Directionality(
      textDirection: GlobalWidgetsLocalizations(
        Locale(Intl.getCurrentLocale()),
      ).textDirection,
      child: CupertinoApp(
        title: "WHO COVID-19",
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        routes: Routes.map,
        // FIXME Issue #1012 - disabled supported languages for P0
        //supportedLocales: S.delegate.supportedLocales,
        initialRoute: widget.showOnboarding ? '/onboarding' : '/',
        navigatorObservers: <NavigatorObserver>[observer],
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Constants.primaryDark,
        ),
      ),
    );
  }
}
