import 'package:WHOFlutter/pages/home_page.dart';
import 'package:WHOFlutter/pages/onboarding/location_sharing_page.dart';
import 'package:WHOFlutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.onboardingComplete != null) {
      return userProvider.onboardingComplete
          ? HomePage()
          : LocationSharingPage();
    } else {
      /// we can show loading or logo here
      return SizedBox();
    }
  }
}
