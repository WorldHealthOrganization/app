import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/main_pages/check_up_page.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';

class AppTabRouter extends StatelessWidget {
  CupertinoTabView wrapTabView(Widget Function(BuildContext) builder) {
    return CupertinoTabView(
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return wrapTabView((context) => HomePage());
          case 1:
            return wrapTabView((context) => RecentNumbersPage());
          case 2:
            return wrapTabView((context) => LearnPage(
                  dataSource: IndexContent.learnIndex,
                ));
          case 3:
            return wrapTabView((context) => CheckUpPage());
          case 4:
            return wrapTabView((context) => SettingsPage());

          default:
            return null;
        }
      },
      tabBar: CupertinoTabBar(
        inactiveColor: CupertinoColors.black,
        activeColor: Constants.accentColor,
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
