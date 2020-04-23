import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/check_up_page.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page/learn_page.dart';
import 'package:who_app/pages/main_pages/settings_page.dart';
import 'package:who_app/pages/main_pages/stats_page.dart';

class HomePageRouter extends StatelessWidget {
  final FirebaseAnalytics analytics;

  const HomePageRouter(this.analytics);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return HomePage();
          case 1:
            return StatsPage();
          case 2:
            return LearnPage();
          case 3:
            return CheckUpPage();
          case 4:
            return SettingsPage();
        }
      },
      tabBar: CupertinoTabBar(
        activeColor: Constants.accent,
        inactiveColor: Constants.primaryDark,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Stats"),
            icon: Icon(CupertinoIcons.circle),
          ),
          BottomNavigationBarItem(
            title: Text("Learn"),
            icon: Icon(CupertinoIcons.search),
          ),
          BottomNavigationBarItem(
            title: Text("Check-Up"),
            icon: Icon(CupertinoIcons.lab_flask),
          ),
          BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(CupertinoIcons.person),
          ),
        ],
      ),
    );
  }
}
