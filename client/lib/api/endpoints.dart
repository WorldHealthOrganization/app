// Endpoint for service

class Endpoint {
  static const _whoMhPrefix = 'who-mh-';
  static const _prodProjectId = 'who-mh-prod';
  static const _prodServiceUrl = 'https://covid19app.who.int';

  static bool _isProd(String projectId) {
    return projectId == _prodProjectId;
  }

  static String _projectIdShort(String projectId) {
    if (!projectId.startsWith(_whoMhPrefix)) {
      throw Exception(
          "Project: $projectId doesn't match prefix: $_whoMhPrefix");
    }
    return projectId.substring(_whoMhPrefix.length);
  }

  static String _serviceUrl(String projectId) {
    if (_isProd(projectId)) {
      return _prodServiceUrl;
    }
    return 'https://${_projectIdShort(projectId)}.whocoronavirus.org';
  }

  final bool isProd;
  final String projectIdShort;
  final String serviceUrl;

  Endpoint(String projectId)
      : isProd = _isProd(projectId),
        projectIdShort = _projectIdShort(projectId),
        serviceUrl = _serviceUrl(projectId);
}
