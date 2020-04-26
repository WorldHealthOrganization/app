import 'dart:io';
import 'package:who_app/api/endpoints.dart';
import 'package:who_app/api/who_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';
import 'caching.dart';
import 'content_bundle.dart';

/// Utilities for loading content bundles (localized YAML files) from the network
/// with fallback to local assets.
class ContentLoading {
  static final networkLoadingEnabled = true;
  static final ContentLoading _singleton = ContentLoading._internal();

  static final String baseContentURL =
      '${Endpoints.PROD}/content/bundles'; // no trailing slash
  static final Duration networkTimeout = Duration(seconds: 3);
  static final String baseAssetPath = 'assets/content_bundles'; // no trailing

  factory ContentLoading() {
    return _singleton;
  }

  ContentLoading._internal();

  /// Load a localized content bundle loaded preferentially from the network, falling back
  /// to a local asset.  If no bundle can be found with the specified name an exception is thrown.
  Future<ContentBundle> load(Locale locale, String name) async {
    var languageCode = locale.languageCode;
    var countryCode = locale.countryCode;
    var languageAndCountry = "${languageCode}_${countryCode}";
    var unsupportedSchemaVersionAvailable = false;

    // Attempt to load the full language and country path from the network.
    // The content server contains linked / duplicated paths as needed such that
    // no explicit fallback to language-only is required.
    if (networkLoadingEnabled) {
      try {
        return await _loadFromNetwork(name, languageAndCountry);
      } catch (err) {
        print("Network bundle for $languageAndCountry not found: $err");
        if (err is ContentBundleSchemaVersionException) {
          unsupportedSchemaVersionAvailable = true;
        }
      }
    }

    // Attempt to load the full language and country path from local resources.
    try {
      return await _loadFromAssets(
          name, languageAndCountry, unsupportedSchemaVersionAvailable);
    } catch (err) {
      print("Local asset bundle for $languageAndCountry not found: $err");
    }

    // Attempt to load the language-only path from local resources.
    try {
      return await _loadFromAssets(
          name, languageCode, unsupportedSchemaVersionAvailable);
    } catch (err) {
      print("Local asset bundle for $languageCode not found: $err");
    }

    // Attempt to load the English bundle from local resources.
    try {
      return await _loadFromAssets(
          name, 'en', unsupportedSchemaVersionAvailable);
    } catch (err) {
      print("Local asset bundle for $languageCode not found: $err");
    }

    // No bundle found.
    throw ContentBundleNotFoundException(
        "Content bundle not found for name: $name");
  }

  /// Load a localized content bundle from the network, throwing an exception if not found.
  Future<ContentBundle> _loadFromNetwork(String name, String suffix) async {
    var url = '$baseContentURL/${_fileName(name, suffix)}';
    final headers = {
      "Accept": "application/yaml",
      "Accept-Encoding": "gzip",
      "User-Agent": WhoService.userAgent,
    };
    File file = await WhoCacheManager()
        .getSingleFile(url, headers: headers)
        .timeout(networkTimeout);
    if (file == null) {
      throw Exception("File not retrieved from network or cache: $url");
    }
    return ContentBundle.fromBytes(await file.readAsBytes());
  }

  /// Load a localized content bundle from local assets, throwing an exception if not found.
  Future<ContentBundle> _loadFromAssets(String name, String suffix,
      bool unsupportedSchemaVersionAvailable) async {
    var path = '$baseAssetPath/${_fileName(name, suffix)}';
    var body = await rootBundle.loadString(path);
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
