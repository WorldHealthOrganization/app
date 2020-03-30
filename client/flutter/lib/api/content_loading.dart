import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'content_bundle.dart';

class ContentLoading {
  static final networkLoadingEnabled = true;
  static final ContentLoading _singleton = ContentLoading._internal();

  // TODO: Real URL
  static final String baseContentURL =
      'https://who.int/covid19/content/v1'; // no trailing
  static final Duration networkTimeout = Duration(seconds: 3);
  static final String baseAssetPath = 'assets/content_bundles'; // no trailing

  factory ContentLoading() {
    return _singleton;
  }

  ContentLoading._internal();

  /// Load a localized content bundle loaded preferentially from the network, falling back
  /// to a local asset.  If no bundle can be found with the specified name an exception is thrown.
  Future<ContentBundle> load(BuildContext context, String name) async {
    Locale locale = Localizations.localeOf(context);
    var languageCode = locale.languageCode;
    var countryCode = locale.countryCode;
    var languageAndCountry = "${languageCode}_${countryCode}";

    // Attempt to load the full language and country path from the network.
    // The content server contains linked / duplicated paths as needed such that
    // no explicit fallback to language-only is required.
    if (networkLoadingEnabled) {
      try {
        return await _loadFromNetwork(name, languageAndCountry);
      } catch (err) {
        print("Network bundle for $languageAndCountry not found: $err");
      }
    }

    // Attempt to load the full language and country path from local resources.
    try {
      return await _loadFromAssets(name, languageAndCountry);
    } catch (err) {
      print("Local asset bundle for $languageAndCountry not found: $err");
    }

    // Attempt to load the language-only path from local resources.
    try {
      return await _loadFromAssets(name, languageCode);
    } catch (err) {
      print("Local asset bundle for $languageCode not found: $err");
    }

    // Attempt to load the English bundle from local resources.
    try {
      return await _loadFromAssets(name, 'en');
    } catch (err) {
      print("Local asset bundle for $languageCode not found: $err");
    }

    // No bundle found.
    throw Exception("Content bundle not found for name: $name");
  }

  /// Load a localized content bundle from the network, throwing an exception if not found.
  Future<ContentBundle> _loadFromNetwork(String name, String suffix) async {
    var url = '$baseContentURL/${_fileName(name, suffix)}';
    var response = await http.get(url,
        headers: {"Content-Type": "application/yaml"}).timeout(networkTimeout);
    if (response.statusCode != 200) {
      throw Exception("Error status code: ${response.statusCode}");
    }
    String body = response.body;
    return ContentBundle.from(body);
  }

  /// Load a localized content bundle from local assets, throwing an exception if not found.
  Future<ContentBundle> _loadFromAssets(String name, String suffix) async {
    var path = '$baseAssetPath/${_fileName(name, suffix)}';
    var body = await rootBundle.loadString(path);
    return ContentBundle.from(body);
  }

  /// Format the filename. e.g. screen_name.en_US.yaml
  String _fileName(String name, String suffix) {
    return '${name}.$suffix.yaml';
  }
}
