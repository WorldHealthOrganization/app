import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchUrl(String url) async {
  return launch(url, forceSafariVC: false, forceWebView: false);
}

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

  Future open(BuildContext context) {
    return isExternal
        ? launchUrl(url)
        : Navigator.of(context, rootNavigator: true)
            .pushNamed(route, arguments: args);
  }

  RouteLink.fromUri(String uri) {
    _url = Uri.parse(uri);
    route = _url.path;
    args = _url.queryParameters ?? {};
  }
}
