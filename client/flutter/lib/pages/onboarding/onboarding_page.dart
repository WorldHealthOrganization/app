import 'package:WHOFlutter/pages/onboarding/legal_landing_page.dart';
import 'package:WHOFlutter/pages/onboarding/location_sharing_page.dart';
import 'package:WHOFlutter/pages/onboarding/notifications_page.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.easeInOut;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (this._pageController.hasClients && this._pageController.page > 0) {
          this._pageController.previousPage(duration: _animationDuration, curve: _animationCurve);
          // Veto this back-press, we already went to previous page
          return Future.value(false);
        }

        // User pressed back on the Get Started page, return false because onboarding was not completed
        Navigator.of(context).pop(false);

        // Veto the back-press, we already popped the onboarding
        return Future.value(false);
      },
      child: PageView(
        controller: this._pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          LegalLandingPage(onNext: _toNextPage),
          NotificationsPage(onNext: _toNextPage),
          LocationSharingPage(onNext: _onDone),
        ],
      ),
    );
  }

  Future<void> _toNextPage() async {
    await _pageController.nextPage(duration: _animationDuration, curve: _animationCurve);
  }

  void _onDone() {
    // Return true because onboarding is completed
    Navigator.of(context).pop(true);
  }
}
