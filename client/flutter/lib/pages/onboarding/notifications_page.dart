import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return PermissionRequestPage(
      pageTitle: "Stay up to date on the Coronavirus",
      pageDescription: "To stay up to date with Coronavirus news, turn on app notifications from the World Health Organization.",
      buttonTitle: "Allow Notifications", // TODO: Localize
      onGrantPermission: _allowNotifications,
      onSkip: _skipNotifications,
    );
  }

  void _allowNotifications() async {
    _complete();
  }

  void _skipNotifications() async {
    _complete();
  }

  void _complete() async {
    Navigator.of(context).pop();
  }
}
