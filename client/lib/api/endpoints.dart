// Endpoint for service

class Endpoint {
  static const _whoMhPrefix = 'who-mh-';
  static const _whoMh2Prefix = 'who-mh2-';

  // TODO: Figure out a way to avoid hardcoding regions in client code.
  static const _region = 'europe-west6';

  static String _projectIdShort(String projectId) {
    if (!projectId.startsWith(_whoMh2Prefix) &&
        !projectId.startsWith(_whoMhPrefix)) {
      throw Exception(
          "Project: $projectId doesn't match prefix: $_whoMhPrefix");
    }
    return projectId.startsWith(_whoMh2Prefix)
        ? projectId.substring(_whoMh2Prefix.length)
        : projectId.substring(_whoMhPrefix.length);
  }

  static String _serviceUrl(String projectId) {
    return 'https://${_region}-${projectId}.cloudfunctions.net';
  }

  static String _staticContentUrl(String projectId) {
    return 'https://${projectId}.web.app';
  }

  // TODO: Hook up prod endpoints once V2 is deployed in prod.
  final bool isProd;
  final String projectIdShort;
  final String serviceUrl;
  final String staticContentUrl;

  Endpoint(String projectId)
      : isProd = false,
        projectIdShort = _projectIdShort(projectId),
        serviceUrl = _serviceUrl(projectId),
        staticContentUrl = _staticContentUrl(projectId);
}
