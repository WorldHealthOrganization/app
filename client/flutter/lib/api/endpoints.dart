import 'package:flutter/foundation.dart';

class Endpoints {
  static final String STAGING_SERVICE = 'https://staging.whocoronavirus.org';
  // TODO: Move this to who.int.
  static final String PROD_SERVICE = 'https://whoapp.org';

  static final String STAGING_STATIC_CONTENT =
      'https://storage.googleapis.com/who-myhealth-staging-static-content-01';
  // TODO: Move this to GCS too.
  static final String PROD_STATIC_CONTENT = 'https://whoapp.org';
}

class Endpoint {
  final String service;
  final String staticContent;

  Endpoint({@required this.service, @required this.staticContent});
}
