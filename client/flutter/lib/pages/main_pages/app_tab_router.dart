import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/main_pages/check_up_page.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';

class AppTabRouter extends StatefulWidget {
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
  ];

  final List<Widget Function(BuildContext)> tabs;
  final List<BottomNavigationBarItem> navItems;

  AppTabRouter(this.tabs, this.navItems);

  @override
  _AppTabRouterState createState() => _AppTabRouterState();
}

class _AppTabRouterState extends State<AppTabRouter> {
  CupertinoTabController _controller;
  FirebaseAnalytics _analytics;
  int lastTabIndex;
  @override
  void initState() {
    _analytics = FirebaseAnalytics();
    _controller = CupertinoTabController();
    lastTabIndex = _controller.index;

    _controller.addListener(
      () {
        int currentIndex = _controller.index;

        String lastTab = tabTitle(lastTabIndex);
        String currentTab = tabTitle(currentIndex);

        lastTabIndex = currentIndex;

        _analytics.logEvent(
          name: 'changed_tabs',
          parameters: {
            'current_tab': currentTab,
            'last_tab': lastTab,
          },
        );
      },
    );
    super.initState();
  }

  String tabTitle(int index) {
    Text txt = AppTabRouter.defaultNavItems[index].title;
    String data = txt.data;
    return data;
  }

  const _AppTabRouterState();

  CupertinoTabView wrapTabView(Widget Function(BuildContext) builder) {
    return CupertinoTabView(
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
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
