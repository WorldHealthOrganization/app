import 'dart:io';

import 'package:WHOFlutter/api/endpoints.dart';
import 'package:WHOFlutter/components/dialogs.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'content_bundle.dart';
import 'package:path/path.dart' as paths;

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
        if (err is ContentBundleVersionException) {
          // TODO: Refactor the loader API to support passing this information
          // TODO: back to the UI layer rather than handling it here.
          // Defer showing the dialog briefly until after screen build.
          Future.delayed(const Duration(seconds: 1), () {
            // TODO: Localize
            Dialogs.showAppDialog(
                context: context,
                title:
                    S.of(context).commonContentLoadingDialogUpdateRequiredTitle,
                // TODO: Provide the sharing link here?
                bodyText: S
                    .of(context)
                    .commonContentLoadingDialogUpdateRequiredBodyText);
          });
        }
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
    final headers = {"Accept": "application/yaml"};
    File file = await WhoCacheManager()
        .getSingleFile(url, headers: headers)
        .timeout(networkTimeout);
    if (file == null) {
      throw Exception("File not retrieved from network or cache: $url");
    }
    return ContentBundle.fromBytes(await file.readAsBytes());
  }

  /// Load a localized content bundle from local assets, throwing an exception if not found.
  Future<ContentBundle> _loadFromAssets(String name, String suffix) async {
    var path = '$baseAssetPath/${_fileName(name, suffix)}';
    var body = await rootBundle.loadString(path);
    return ContentBundle.fromString(body);
  }

  /// Format the filename. e.g. screen_name.en_US.yaml
  String _fileName(String name, String suffix) {
    return '${name}.$suffix.yaml';
  }
}

class WhoCacheManager extends BaseCacheManager {
  static const key = "whoCache";

  static WhoCacheManager _instance;

  // Attempting to change the maxAgeCacheObject parameter here has no effect
  // on http content, for which the manager uses the cache control max-age header.
  WhoCacheManager._init() : super(key);

  factory WhoCacheManager() {
    if (_instance == null) {
      _instance = WhoCacheManager._init();
    }
    return _instance;
  }

  // This changes the behavior of the base method to wait for an update of the
  // expired file before returning, rather than favoring the cached version.
  @override
  Future<File> getSingleFile(String url, {Map<String, String> headers}) async {
    final cacheFile = await getFileFromCache(url);
    if (cacheFile != null) {
      if (cacheFile.validTill.isBefore(DateTime.now())) {
        // Wait for the refreshed file.
        try {
          await webHelper.downloadFile(url, authHeaders: headers);
        } catch (err) {
          print(
              "Error refreshing expired file, returning cached version: $url");
        }
      }
      return cacheFile.file;
    }
    try {
      print("Downloading file: $url");
      final download = await webHelper.downloadFile(url, authHeaders: headers);
      return download.file;
    } catch (e) {
      print("Error downloading file: $url, $e");
      return null;
    }
  }

  // Store files in the temporary system path (default behavior)
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return paths.join(directory.path, key);
  }
}
