import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/latest_numbers.dart';
import 'package:who_app/pages/main_pages/check_up_page.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';

class AppTabRouter extends StatelessWidget {
  final FirebaseAnalytics analytics;

  AppTabRouter(this.analytics);

  // _logAnalyticsEvent(String name) async {
  //   await analytics.logEvent(name: name);
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return HomePage();
          case 1:
            return LatestNumbersPage();
          case 2:
            return LearnPage();
          case 3:
            return CheckUpPage();
          case 4:
            return SettingsPage();

          default:
            return null;
        }
      },
      tabBar: CupertinoTabBar(
        inactiveColor: Colors.black,
        activeColor: Constants.accent,
        items: [
          BottomNavigationBarItem(
              // TODO: localize title strings
              icon: Icon(CupertinoIcons.home),
              title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.circle), title: Text("Stats")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), title: Text("Learn")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.lab_flask), title: Text("Check-Up")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text("Settings")),
        ],
      ),
    );
  }
}
