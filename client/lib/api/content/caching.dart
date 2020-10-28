import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as paths;

class WhoCacheManager extends BaseCacheManager {
  // Change this key when the cache database becomes incompatible with the prior cache.
  static const key = 'whoCache2';

  static WhoCacheManager _instance;

  // If you don't have a network connection for >10 years, you don't update
  // the app, or we have more than 10000 content bundles, you might get old content.
  // Note that we use cached http content even after the http cache headers indicate
  // expiration if they are newer than the content in the app binary, which is why
  // we keep that content around for 5000 days instead of the default 30 days.
  WhoCacheManager._init()
      : super(key,
            maxAgeCacheObject: const Duration(days: 5000),
            maxNrOfCacheObjects: 10000);

  factory WhoCacheManager() {
    _instance ??= WhoCacheManager._init();
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
          if (await Connectivity().checkConnectivity() ==
              ConnectivityResult.none) {
            // Avoid waiting until timeout
            throw Exception(
                'No internet connectivity - will not attempt download');
          }
          return (await webHelper.downloadFile(url, authHeaders: headers)).file;
        } catch (err) {
          print(
              'Error refreshing expired file, returning cached version: $url');
        }
      } else {
        print('Using cached $url until ${cacheFile.validTill}');
      }
      return cacheFile.file;
    }
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        // Avoid waiting until timeout
        throw Exception('No internet connectivity - will not attempt download');
      }
      print('Downloading file: $url');
      final download = await webHelper.downloadFile(url, authHeaders: headers);
      return download.file;
    } catch (e) {
      print('Error downloading file: $url, $e');
      return null;
    }
  }

  // Store files in the temporary system path (default behavior)
  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return paths.join(directory.path, key);
  }
}
