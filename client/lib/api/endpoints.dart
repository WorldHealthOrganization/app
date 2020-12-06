// Endpoint for service

class Endpoint {
  static const _whoMhPrefix = 'who-mh-';
  static const _prodProjectId = 'who-mh-prod';
  static const _prodServiceUrl = 'https://covid19app.who.int';

  static bool _isProd(String projectId) {
    return projectId == _prodProjectId;
  }

  static String _serviceUrl(String projectId) {
    if (_isProd(projectId)) {
      return _prodServiceUrl;
    }
    if (projectId.startsWith(_whoMhPrefix)) {
      final subdomain = projectId.substring(_whoMhPrefix.length);
      return 'https://${subdomain}.whocoronavirus.org';
    }
    throw Exception("Project: $projectId doesn't match prefix: $_whoMhPrefix");
  }

  final String service;
  final bool isProd;

  Endpoint(String projectId)
      : service = _serviceUrl(projectId),
        isProd = _isProd(projectId);
}
