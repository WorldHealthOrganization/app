import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsPage extends StatefulWidget  {
  final PageController pageController;
  NotificationsPage(this.pageController);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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

    await _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _registerFCMToken();

    _complete();
  }

  void _skipNotifications() async {
    Navigator.pop(context);
  }

  void _complete() {
    this.widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _registerFCMToken() {
     _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);

      //TODO: Make call to web service to register the token. 

    });
  }
}
