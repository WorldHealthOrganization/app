import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:WHOFlutter/api/who_service.dart';
import 'dart:io';

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
    if (Platform.isIOS) {
      await _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false));
    }
    
    await UserPreferences().setNotificationsEnabled(true);
    _registerFCMToken();
    _complete();
  }

  void _skipNotifications() async {
    await UserPreferences().setNotificationsEnabled(false);
    _complete();
  }

  void _complete() {
    widget.onNext();
  }

  void _registerFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    await WhoService.putDeviceToken(token);
    await UserPreferences().setFCMToken(token);
  }
}
