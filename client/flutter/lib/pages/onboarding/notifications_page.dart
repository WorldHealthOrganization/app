import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/onboarding_page.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:WHOFlutter/api/who_service.dart';

class NotificationsPage extends StatefulWidget {
  final VoidCallback onNext;

  const NotificationsPage({@required this.onNext}) : assert(onNext != null);
  
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
      backgroundImageSrc: S.of(context).notificationsPagePermissionRequestBackgroundImage,
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

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    await _registerFCMToken();

    _complete();
  }

  void _skipNotifications() async {
    _complete();
  }

  void _complete() {
    widget.onNext();
  }

  void _registerFCMToken() async {
    await _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
      
      WhoService.putDeviceToken(token);
    });
  }
}
