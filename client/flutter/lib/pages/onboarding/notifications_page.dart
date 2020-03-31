import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/onboarding_page.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget  {
  final OnboardingPage onboardingPage;
  NotificationsPage(this.onboardingPage);

  @override
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
    _complete();
  }

  void _skipNotifications() async {
    Navigator.pop(context);
  }

  void _complete() {
    this.widget.onboardingPage.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
