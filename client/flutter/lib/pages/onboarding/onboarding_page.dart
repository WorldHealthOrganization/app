import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/pages/onboarding/legal_landing_page.dart';
import 'package:who_app/pages/onboarding/location_sharing_page.dart';
import 'package:who_app/pages/onboarding/notifications_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.easeInOut;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If a previous page exists
        if (_pageController.hasClients && _pageController.page > 0) {
          await _pageController.previousPage(
            duration: _animationDuration,
            curve: _animationCurve,
          );
          // Veto this back-press, we already went to previous page
          return false;
        }

        return true;
      },
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          LegalLandingPage(onNext: _onLegalDone),
          NotificationsPage(onNext: _toNextPage),
          LocationSharingPage(onNext: _onDone),
        ],
      ),
    );
  }

  Future<void> _onLegalDone() async {
    // Enable auto init so that analytics will work
    await _firebaseMessaging.setAutoInitEnabled(true);
    await _toNextPage();
  }

  Future<void> _toNextPage() async {
    await _pageController.nextPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  void _onDone() async {
    await UserPreferences().setOnboardingCompleted(true);
    await UserPreferences().setAnalyticsEnabled(true);
    await Navigator.of(context, rootNavigator: true).pushReplacementNamed(
      '/home',
    );
  }
}
