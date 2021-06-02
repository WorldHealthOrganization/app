import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/api/user_preferences_store.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

import 'check_up/check_up_page.dart';

class AppTabRouter extends StatelessWidget {
  static final List<Widget Function(BuildContext)> defaultTabs = [
    (context) => HomePage(
          dataSource: Provider.of<ContentStore>(context),
        ),
    (context) => CheckUpPage(
          dataSource: Provider.of<ContentStore>(context),
        ),
    (context) => LearnPage(
          dataSource: Provider.of<ContentStore>(context),
        ),
    (context) => RecentNumbersPage(
          statsStore: Provider.of<StatsStore>(context),
        ),
    (context) => SettingsPage(
          notifications: Provider.of<Notifications>(context),
          service: Provider.of<WhoService>(context),
          prefs: Provider.of<UserPreferencesStore>(context),
        ),
  ];

  static final List<BottomNavigationBarItem> defaultNavItems = [
    _buildSvgNavItem(
      iconName: 'streamline-nav-home',
      title: 'Home',
      activeColor: Constants.accentColor,
    ),
    _buildSvgNavItem(
      iconName: 'streamline-nav-checkup',
      title: 'Check-Up',
      activeColor: Constants.accentColor,
    ),
    _buildSvgNavItem(
      iconName: 'streamline-nav-learn',
      title: 'Learn',
      activeColor: Constants.accentColor,
    ),
    _buildSvgNavItem(
      iconName: 'streamline-nav-stats',
      title: 'Stats',
      activeColor: Constants.accentColor,
    ),
    _buildSvgNavItem(
      iconName: 'streamline-nav-settings',
      title: 'Settings',
      activeColor: Constants.accentColor,
    ),
  ];

  final List<Widget Function(BuildContext)> tabs;
  final List<BottomNavigationBarItem> navItems;
  final ContentStore dataSource;

  AppTabRouter(
      {required this.dataSource, required this.tabs, required this.navItems});

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
        return Container();
      },
      tabBar: CupertinoTabBar(
        inactiveColor: CupertinoColors.black,
        activeColor: Constants.accentColor,
        items: navItems,
      ),
    );
  }

  static BottomNavigationBarItem _buildSvgNavItem(
      {String? iconName, String? title, required Color activeColor}) {
    final assetName = 'assets/svg/${iconName}.svg';
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(assetName),
      activeIcon: SvgPicture.asset(
        assetName,
        color: activeColor,
      ),
      label: title,
    );
  }
}
