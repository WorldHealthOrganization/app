import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/settings_page.dart';

class HomePageRouter extends StatelessWidget {
  final FirebaseAnalytics analytics;

  HomePageRouter(this.analytics);

  _logAnalyticsEvent(String name) async {
    await analytics.logEvent(name: name);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return HomePage();
          case 1:
            return HomePage();
          case 2:
            return HomePage();

          case 3:
            return HomePage();
          case 4:
            return SettingsPage();

          default:
            return null;
        }
      },
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text("Home")),
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
