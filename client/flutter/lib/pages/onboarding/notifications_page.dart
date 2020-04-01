import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final VoidCallback onNext;

  const NotificationsPage({@required this.onNext}) : assert(onNext != null);

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
    _complete();
  }

  void _complete() {
    widget.onNext();
  }
}
