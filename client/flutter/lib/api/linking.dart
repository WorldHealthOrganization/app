import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_app/pages/main_pages/app_tab_router.dart';

class RouteLink {
  Uri _url;
  String route;
  Map<String, String> args;

  bool get isExternal {
    try {
      return _url?.origin != null;
    } catch (error) {
      return false;
    }
  }

  String get url => _url?.toString();

  RouteLink({
    @required this.route,
    @required this.args,
  });

  Future open(BuildContext context) async {
    if (isExternal) {
      await launch(url);
    } else {
      /// Intercepted by the [AppTabRouter] which decides whether to switch
      /// home page tabs or to push the route with the provided arguments 
      SwitchTabNotification(
        args: args,
        route: route,
      ).dispatch(context);
    }

    /* return this.isExternal
        ? launch(this.url)
        : Navigator.of(context, rootNavigator: true)
            .pushNamed(this.route, arguments: this.args); */
  }

  RouteLink.fromUri(String uri) {
    _url = Uri.parse(uri);
    route = _url.path;
    args = _url.queryParameters ?? {};
  }
}
