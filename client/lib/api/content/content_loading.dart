import 'package:who_app/api/endpoints.dart';
import 'package:who_app/api/who_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'caching.dart';
import 'content_bundle.dart';

/// Utilities for loading content bundles (localized YAML files) from the network
/// with fallback to local assets.
class ContentService {
  static final networkLoadingEnabled = true;

  final String baseContentURL;
  static final Duration networkTimeout = Duration(seconds: 30);
  static final String baseAssetPath = 'assets/content_bundles'; // no trailing

  ContentService({@required Endpoint endpoint})
      : baseContentURL = '${endpoint.serviceUrl}/content/bundles';

  /// Load a localized content bundle loaded preferentially from the network, falling back
  /// to a local asset.  If no bundle can be found with the specified name an exception is thrown.
  Future<ContentBundle> load(
      Locale locale, String countryIsoCode, String name) async {
    final languageCode = locale.languageCode;
    final countryCode = countryIsoCode ?? locale.countryCode;
    final languageAndCountry = '${languageCode}_${countryCode}';
    var unsupportedSchemaVersionAvailable = false;

    ContentBundle networkBundle;

    // Attempt to load the full language and country path from the network.
    // The content server contains linked / duplicated paths as needed such that
    // no explicit fallback to language-only is required.
    if (networkLoadingEnabled) {
      try {
        networkBundle = await _loadFromNetwork(name, languageAndCountry);
      } catch (err) {
        print(
            'Loading $name : Network bundle for $languageAndCountry not found: $err');
        if (err is ContentBundleSchemaVersionException) {
          unsupportedSchemaVersionAvailable = true;
        }
      }
    }

    final localBundle = await _loadFromAssetsWithFallback(name,
        languageAndCountry, unsupportedSchemaVersionAvailable, languageCode);

    if (localBundle == null && networkBundle == null) {
      // No bundle found.
      throw ContentBundleNotFoundException(
          'Loading $name : Content bundle not found');
    } else if ((networkBundle?.contentVersion ?? 0) >
        (localBundle?.contentVersion ?? 0)) {
      print(
          'Loading $name : Using #network bundle v${networkBundle?.contentVersion ?? 0} instead of local v${localBundle?.contentVersion ?? 0}');
      return networkBundle;
    } else {
      print(
          'Loading $name : Using *local bundle v${localBundle?.contentVersion ?? 0} instead of network v${networkBundle?.contentVersion ?? 0}');
      return localBundle;
    }
  }

  Future<ContentBundle> _loadFromAssetsWithFallback(
      String name,
      String languageAndCountry,
      bool unsupportedSchemaVersionAvailable,
      String languageCode) async {
    // Attempt to load the full language and country path from local resources.
    try {
      return await _loadFromAssets(
          name, languageAndCountry, unsupportedSchemaVersionAvailable);
    } catch (err) {
      print(
          'Loading $name : Local asset bundle for $languageAndCountry not found: $err');
    }

    // Attempt to load the language-only path from local resources.
    try {
      return await _loadFromAssets(
          name, languageCode, unsupportedSchemaVersionAvailable);
    } catch (err) {
      print(
          'Loading $name : Local asset bundle for $languageCode not found: $err');
    }

    // Attempt to load the English bundle from local resources.
    try {
      return await _loadFromAssets(
          name, 'en', unsupportedSchemaVersionAvailable);
    } catch (err) {
      print('Loading $name : Local asset bundle for en not found: $err');
    }

    return null;
  }

  /// Load a localized content bundle from the network, throwing an exception if not found.
  Future<ContentBundle> _loadFromNetwork(String name, String suffix) async {
    var url = '$baseContentURL/${_fileName(name, suffix)}';
    final headers = {
      'Accept': 'application/yaml',
      'Accept-Encoding': 'gzip',
      'User-Agent': WhoService.userAgent,
    };
    var file = await WhoCacheManager()
        .getSingleFile(url, headers: headers)
        .timeout(networkTimeout);
    if (file == null) {
      throw Exception('File not retrieved from network or cache: $url');
    }
    print('loaded $url');
    return ContentBundle.fromBytes(await file.readAsBytes());
  }

  /// Load a localized content bundle from local assets, throwing an exception if not found.
  Future<ContentBundle> _loadFromAssets(String name, String suffix,
      bool unsupportedSchemaVersionAvailable) async {
    var path = '$baseAssetPath/${_fileName(name, suffix)}';
    var body = await rootBundle.loadString(path, cache: false);
    return ContentBundle.fromString(body,
        unsupportedSchemaVersionAvailable: unsupportedSchemaVersionAvailable);
  }

  /// Format the filename. e.g. screen_name.en_US.yaml
  String _fileName(String name, String suffix) {
    return '${name}.$suffix.yaml';
  }
}

class ContentBundleNotFoundException implements Exception {
  final String cause;

  ContentBundleNotFoundException(this.cause);
}
