import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:observer_provider/observer_provider.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/alerts.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/endpoints.dart';
import 'package:who_app/api/iso_country.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/api/updateable.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/api/user_preferences_store.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/generated/build.dart';
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

import 'package:who_app/api/content/content_loading.dart';

PackageInfo _packageInfo;

PackageInfo get packageInfo => _packageInfo;

void main() async {
  await mainImpl(routes: Routes.map);
}

void mainImpl({@required Map<String, WidgetBuilder> routes}) async {
  // Asyncronous code that runs before the splash screen is hidden goes before
  // runApp()
  if (!kIsWeb) {
    // Initialises binding so we can use the framework before calling runApp
    WidgetsFlutterBinding.ensureInitialized();
    _packageInfo = await PackageInfo.fromPlatform();
  }

  final onboardingComplete = await UserPreferences().getOnboardingCompletedV1();

  // Comment the above lines out and uncomment this to force onboarding in development
  // final bool onboardingComplete = false;

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  // Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = _onFlutterError;

  await runZonedGuarded<Future<void>>(
    () async {
      runApp(MyApp(showOnboarding: !onboardingComplete, routes: routes));
    },
    _onError,
  );
}

Future<void> _onFlutterError(FlutterErrorDetails details) async {
  if (await UserPreferences().getOnboardingCompletedV1()) {
    // Pass all uncaught errors from the framework to Crashlytics.
    await FirebaseCrashlytics.instance.recordFlutterError(details);
  }
}

Future<void> _onError(Object error, StackTrace stack) async {
  if (await UserPreferences().getOnboardingCompletedV1()) {
    await FirebaseCrashlytics.instance.recordError(error, stack);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key, @required this.showOnboarding, @required this.routes})
      : super(key: key);
  final bool showOnboarding;
  final Map<String, WidgetBuilder> routes;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState(analytics, observer);
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  _MyAppState(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        _getCurrentLocale(),
      ).textDirection,
      child: MaterialApp(
        title: 'WHO COVID-19',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        routes: widget.routes,
        // FIXME Issue #1012 - disabled supported languages for P0
        //supportedLocales: S.delegate.supportedLocales,
        initialRoute: widget.showOnboarding ? '/onboarding' : '/home',

        /// allows routing to work without a [Navigator.defaultRouteName] route
        builder: (context, child) => MultiProvider(
          providers: [
            ProxyProvider0(
              lazy: false,
              update: (ctx, _) => Localizations.localeOf(ctx),
            ),
            Provider(
              create: (_) => BuildInfo.DEVELOPMENT_ONLY
                  ? Endpoint(
                      service: Endpoints.STAGING_SERVICE,
                      staticContent: Endpoints.STAGING_STATIC_CONTENT)
                  : Endpoint(
                      service: Endpoints.PROD_SERVICE,
                      staticContent: Endpoints.PROD_STATIC_CONTENT),
            ),
            FutureProvider(
              create: (_) => IsoCountryList.load(),
              initialData: IsoCountryList.empty(),
            ),
            FutureProvider(
              create: (_) => UserPreferencesStore.readFromSharedPreferences(),
              initialData: UserPreferencesStore.empty(),
            ),
            ProxyProvider(
                update: (_, Endpoint endpoint, __) => WhoService(
                      endpoint: endpoint.service,
                    )),
            ProxyProvider(
              update: (_, WhoService service, __) {
                final ret = Notifications(service: service);
                ret.configure();
                ret.updateFirebaseToken();
                return ret;
              },
            ),
            ObserverProvider2(observerFn: (
              _,
              WhoService service,
              UserPreferencesStore prefs,
            ) {
              final ret = StatsStore(
                service: service,
                countryIsoCode: prefs.countryIsoCode,
              );
              ret.update();
              return ret;
            }),
            PeriodicUpdater.asProvider<StatsStore>(),
            ProxyProvider(
                update: (_, Endpoint endpoint, __) => ContentService(
                      endpoint: endpoint.staticContent,
                    )),
            ObserverProvider3(observerFn: (
              _,
              ContentService service,
              Locale locale,
              UserPreferencesStore prefs,
            ) {
              final ret = ContentStore(
                service: service,
                locale: locale,
                countryIsoCode: prefs.countryIsoCode,
              );
              ret.update();
              return ret;
            }),
            PeriodicUpdater.asProvider<ContentStore>(),
            ObserverProvider1<ContentStore, List<Alert>>(
                observerFn: (_, ContentStore content) {
              return [
                if (BuildInfo.DEVELOPMENT_ONLY)
                  Alert(null,
                      'No privacy on development builds. Content not reviewed by WHO.',
                      dismissable: true),
                if (content.unsupportedSchemaVersionAvailable)
                  Alert('App Update Required',
                      'This information may be outdated. You must update this app to receive more recent COVID-19 info.'),
              ];
            }),
          ],
          child: child,
          builder: (ctx, child) {
            final alerts = Provider.of<List<Alert>>(ctx);
            return AlertsWrapper(alerts: alerts, child: child);
          },
        ),
        navigatorObservers: <NavigatorObserver>[observer],
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Constants.primaryDarkColor,
          textTheme: TextTheme(),
          cupertinoOverrideTheme: CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: Constants.primaryDarkColor,
            textTheme: CupertinoTextThemeData(
              textStyle: ThemedText.styleForVariant(TypographyVariant.body),
            ),
          ),
        ),
      ),
    );
  }

  /// Construct the Locale from the Intl locale string.
  /// This allows us to get the Locale outside of the main build context.
  Locale _getCurrentLocale() {
    var parts = Intl.getCurrentLocale().split('_');
    return Locale(parts[0], parts[1]);
  }
}
