class RouteLink {
  Uri _url;

  String get route => _url.path;
  Map<String, String> get args => _url.queryParameters ?? {};
  bool get isExternal {
    try {
      return _url.origin != null;
    } catch (error) {
      return false;
    }
  }

  String get url => _url.toString();

  RouteLink();

  RouteLink.fromUri(String uri) {
    _url = Uri.parse(uri);
  }
}
