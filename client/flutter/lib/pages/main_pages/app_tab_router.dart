import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/check_up_intro_page.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class AppTabRouter extends StatefulWidget {
  static List<Widget Function(BuildContext)> defaultTabs = [
    (context) => HomePage(
          dataSource: IndexContent.homeIndex,
        ),
    (context) => CheckUpIntroPage(),
    (context) => LearnPage(
          dataSource: IndexContent.learnIndex,
        ),
    (context) => RecentNumbersPage(),
    (context) => SettingsPage(),
  ];

  static List<BottomNavigationBarItem> defaultNavItems = [
    BottomNavigationBarItem(
      // TODO: localize title strings
      icon: Icon(CupertinoIcons.home),
      title: Text("Home"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.lab_flask),
      title: Text("Check-Up"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text("Learn"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.circle),
      title: Text("Stats"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      title: Text("Settings"),
    ),
  ];

  final List<BottomNavigationBarItem> navItems;
  final List<Widget Function(BuildContext)> tabs;

  const AppTabRouter({
    Key key,
    @required this.navItems,
    @required this.tabs,
  }) : super(key: key);
  @override
  _AppTabRouterState createState() => _AppTabRouterState();
}

class _AppTabRouterState extends State<AppTabRouter> {
  // Added a tab controller and analytics
  CupertinoTabController _controller;
  FirebaseAnalytics _analytics;

  @override
  void initState() {
    super.initState();

    // Initialized controller and analytics
    _controller = CupertinoTabController();
    _analytics = FirebaseAnalytics();

    _controller.addListener(
      () {
        int currentIndex = _controller.index;

        // Changes the tab from the index to the title
        String currentTab = tabTitle(currentIndex);

        // Sets the analytic's screen to the tab
        _analytics.setCurrentScreen(screenName: currentTab);
      },
    );
  }

  String tabTitle(int index) {
    Text txt = widget.navItems[index].title;
    String data = txt.data;
    return data;
  }

  Widget wrapTabView(Widget Function(BuildContext) builder) {
    return Material(
      child: CupertinoTabView(
        builder: builder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBuilder: (BuildContext context, int index) {
        if (index < widget.tabs.length) {
          return wrapTabView(widget.tabs[index]);
        }
        return null;
      },
      tabBar: CupertinoTabBar(
        inactiveColor: CupertinoColors.black,
        activeColor: Constants.accentColor,
        items: widget.navItems,
      ),
    );
  }
}
