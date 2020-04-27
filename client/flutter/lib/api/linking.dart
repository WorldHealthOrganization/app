import 'package:meta/meta.dart';

class RouteLink {
  String route;
  Map<String, String> args;

  RouteLink({
    @required this.route,
    @required this.args,
  });

  RouteLink.fromUri(String uri) {
    final url = Uri.parse(uri);
    route = url.path;
    args = url.queryParameters ?? {};
  }
}
