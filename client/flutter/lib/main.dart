import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'pages/home_page.dart';
import './constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _registerLicenses();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
            
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
       
      });

    });
  }

  Future<LicenseEntry> _loadLicense() async {
    final licenseText = await rootBundle.loadString('assets/REPO_LICENSE');
    return LicenseEntryWithLineBreaks(["https://github.com/WorldHealthOrganization/app"], licenseText);
  }

  Future<LicenseEntry> _load3pLicense() async {
    final licenseText = await rootBundle.loadString('assets/THIRD_PARTY_LICENSE');
    return LicenseEntryWithLineBreaks(["https://github.com/WorldHealthOrganization/app - THIRD_PARTY_LICENSE"], licenseText);
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
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(
            buttonColor: Constants.primaryColor,
            textTheme: ButtonTextTheme.accent),
      ),
      home: Directionality(
          child: HomePage(),
          textDirection:
              GlobalWidgetsLocalizations(Locale(Intl.getCurrentLocale()))
                  .textDirection),
    );
  }
}
