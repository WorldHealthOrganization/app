import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:who_app/main.dart' show mainImpl;
import 'package:who_app/pages/main_pages/app_tab_router.dart';
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:who_app_en/pages/exposures_page.dart';

void main() async {
  final routes = Map<String, WidgetBuilder>.from(Routes.map);
  final tabs =
      List<Widget Function(BuildContext)>.from(AppTabRouter.defaultTabs);
  final navItems =
      List<BottomNavigationBarItem>.from(AppTabRouter.defaultNavItems);
  tabs.insert(tabs.length - 1, (context) => ExposuresPage());
  navItems.insert(
    navItems.length - 1,
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bluetooth), title: Text("Exposure")),
  );
  routes['/'] = (context) => AppTabRouter(tabs, navItems);
  await mainImpl(routes: routes);
}
