import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return PermissionRequestPage(
     pageTitle: S.of(context).notificationsPagePermissionRequestPageTitle,
      pageDescription: S.of(context).notificationsPagePermissionRequestPageDescription,
      buttonTitle: S.of(context).notificationsPagePermissionRequestPageButton,
      backgroundImageSrc: "assets/onboarding/onboarding_notifications.png",
      onGrantPermission: _allowNotifications,
      onSkip: _skipNotifications,
    );
  }

  void _allowNotifications() async {

    // iOS needs a call for permissions but Android doesn't. 
    // If the user opts-out on Android we just don't register the device token. 
    await _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));

    await _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _registerFCMToken();

    _complete();
  }

  void _skipNotifications() async {
       _complete();
  }

  void _complete() async {
    Navigator.of(context).pop();
  }

  void _registerFCMToken() {
     _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);

      //TODO: Make call to web service to register the token. 

    });
  }
}
