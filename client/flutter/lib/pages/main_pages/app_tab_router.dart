import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/main_pages/check_up_page.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';

class AppTabRouter extends StatelessWidget {
  static final List<Widget Function(BuildContext)> defaultTabs = [
    (context) => HomePage(
          dataSource: IndexContent.homeIndex,
        ),
    (context) => RecentNumbersPage(),
    (context) => LearnPage(
          dataSource: IndexContent.learnIndex,
        ),
    (context) => CheckUpPage(),
    (context) => SettingsPage(),
  ];

  static final List<BottomNavigationBarItem> defaultNavItems = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/bottom_icons/house.svg'),
        activeIcon: SvgPicture.asset(
          "assets/svg/bottom_icons/house.svg",
          color: Constants.accentColor,
        ),
        title: Text("Home")),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/bottom_icons/earth-model.svg'),
        activeIcon: SvgPicture.asset(
          "assets/svg/bottom_icons/earth-model.svg",
          color: Constants.accentColor,
        ),
        title: Text("Stats")),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/bottom_icons/search.svg'),
        activeIcon: SvgPicture.asset(
          "assets/svg/bottom_icons/search.svg",
          color: Constants.accentColor,
        ),
        title: Text("Learn")),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/svg/bottom_icons/medical.svg'),
      activeIcon: SvgPicture.asset(
        "assets/svg/bottom_icons/medical.svg",
        color: Constants.accentColor,
      ),
      title: Text("Settings"),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/svg/bottom_icons/settings.svg",
      ),
      activeIcon: SvgPicture.asset(
        "assets/svg/bottom_icons/settings.svg",
        color: Constants.accentColor,
      ),
      title: Text("Settings"),
    ),
  ];

  BottomNavigationBarItem tabBarItem(
      {@required String title, @required String iconPath}) {}

  final List<Widget Function(BuildContext)> tabs;
  final List<BottomNavigationBarItem> navItems;

  AppTabRouter(this.tabs, this.navItems);

  CupertinoTabView wrapTabView(Widget Function(BuildContext) builder) {
    return CupertinoTabView(
      navigatorObservers: [],
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        if (index < tabs.length) {
          return wrapTabView(tabs[index]);
        }
        return null;
      },
      tabBar: CupertinoTabBar(
        inactiveColor: CupertinoColors.black,
        activeColor: Constants.accentColor,
        items: navItems,
      ),
    );
  }
}
