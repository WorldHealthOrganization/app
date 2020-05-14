import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/components/platform_widget.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/check_up_intro_page.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/main_pages/home_page.dart';
import 'package:who_app/pages/main_pages/learn_page.dart';
import 'package:who_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class AppTabRouter extends StatefulWidget {
  static final List<Widget Function(BuildContext)> defaultTabs = [
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

  static final List<BottomNavigationBarItem> defaultNavItems = [
    BottomNavigationBarItem(
        // TODO: localize title strings
        icon: Icon(CupertinoIcons.home),
        title: Text("Home")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.lab_flask), title: Text("Check-Up")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("Learn")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.circle), title: Text("Stats")),
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
  int currentIndex = 0;
  final Color selectedColor = Constants.accentColor;
  final Color unselectedColor = Colors.black;

  Widget wrapTabView(Widget Function(BuildContext) builder) {
    return Material(
      child: CupertinoTabView(
        builder: builder,
      ),
    );
  }

  void _switchPage(int index) {
    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.tabs[currentIndex](context),
      extendBody: Theme.of(context).platform == TargetPlatform.iOS,
      bottomNavigationBar: PlatformWidget(
        material: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _switchPage,
          items: widget.navItems,
          selectedItemColor: selectedColor,
          unselectedItemColor: unselectedColor,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
        ),
        cupertino: CupertinoTabBar(
          currentIndex: currentIndex,
          onTap: _switchPage,
          items: widget.navItems,
          activeColor: selectedColor,
          inactiveColor: unselectedColor,
        ),
      ),
    );
  }
}
