// Endpoint for service

class Endpoint {
  static const _whoMhPrefix = 'who-mh-';
  static const _whoMh2Prefix = 'who-mh2-';
  static const _prodProjectId = 'who-mh-prod';
  static const _prodServiceUrl = 'https://covid19app.who.int';

  static const _region = 'europe-west6';

  static bool _isProd(String projectId) {
    return projectId == _prodProjectId;
  }

  static String _projectIdShort(String projectId) {
    if (!projectId.startsWith(_whoMh2Prefix) &&
        !projectId.startsWith(_whoMhPrefix)) {
      throw Exception(
          "Project: $projectId doesn't match prefix: $_whoMhPrefix");
    }
    return _isProd(projectId)
        ? projectId.substring(_whoMhPrefix.length)
        : projectId.substring(_whoMh2Prefix.length);
  }

  static String _serviceUrl(String projectId) {
    if (_isProd(projectId)) {
      return '${_prodServiceUrl}/WhoService';
    }
    return 'https://${_region}-${projectId}.cloudfunctions.net';
  }

  static String _staticContentUrl(String projectId) {
    if (_isProd(projectId)) {
      return _prodServiceUrl;
    }
    return 'https://${projectId}.web.app';
  }

  final bool isProd;
  final String projectIdShort;
  final String serviceUrl;
  final String staticContentUrl;

  Endpoint(String projectId)
      : isProd = _isProd(projectId),
        projectIdShort = _projectIdShort(projectId),
        serviceUrl = _serviceUrl(projectId),
        staticContentUrl = _staticContentUrl(projectId);
}
