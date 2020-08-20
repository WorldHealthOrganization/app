import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as paths;

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
        print('Cached $url expired ${cacheFile.validTill}');
        // Wait for the refreshed file.
        try {
          await webHelper.downloadFile(url, authHeaders: headers);
        } catch (err) {
          print(
              "Error refreshing expired file, returning cached version: $url");
        }
      } else {
        print('Using cached $url until ${cacheFile.validTill}');
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
