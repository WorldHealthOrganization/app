import 'package:WHOFlutter/pages/onboarding/legal_landing_page.dart';
import 'package:WHOFlutter/pages/onboarding/location_sharing_page.dart';
import 'package:WHOFlutter/pages/onboarding/notifications_page.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: this.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        LegalLandingPage(this),
        NotificationsPage(this),
        LocationSharingPage(this)
      ],
    );
  }
}
