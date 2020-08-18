import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:who_app/main.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

import 'package:who_app/proto/api/who/who.pb.dart';

class WhoService {
  final String serviceUrl;

  WhoService({@required String endpoint}) : serviceUrl = '$endpoint/WhoService';

  /// Put device token.
  Future<bool> putDeviceToken(String token) async {
    Map<String, String> headers = await _getHeaders();
    var postBody = jsonEncode({"token": token});
    var url = '$serviceUrl/putDeviceToken';
    var response = await http.post(url, headers: headers, body: postBody);
    if (response.statusCode != 200) {
      throw Exception("Error status code: ${response.statusCode}");
    }
    return true;
  }

  /// Put location
  Future<bool> putLocation({String isoCountryCode}) async {
    Map<String, String> headers = await _getHeaders();
    var postBody = jsonEncode({
      "isoCountryCode": isoCountryCode,
    });
    var url = '$serviceUrl/putLocation';
    var response = await http.post(url, headers: headers, body: postBody);
    if (response.statusCode != 200) {
      throw Exception("Error status code: ${response.statusCode}");
    }
    return true;
  }

  Future<GetCaseStatsResponse> getCaseStats() async {
    Map<String, String> headers = await _getHeaders();
    var url = '$serviceUrl/getCaseStats';
    var response = await http.post(url, headers: headers, body: '');
    if (response.statusCode != 200) {
      throw Exception("Error status code: ${response.statusCode}");
    }
    final ret = GetCaseStatsResponse.create();
    ret.mergeFromProto3Json(jsonDecode(response.body));
    return ret;
  }

  static Future<Map<String, String>> _getHeaders() async {
    var clientId = await UserPreferences().getClientUuid();
    var headers = {
      'Content-Type': 'application/json',
      'Who-Client-ID': clientId,
      'Who-Platform': _platform,
      'User-Agent': userAgent,
      'Accept-Encoding': 'gzip',
    };
    return headers;
  }

  static String get userAgent {
    return 'WHO-App/${_platform}/${packageInfo != null ? packageInfo.version : ''}/${packageInfo != null ? packageInfo.buildNumber : ''} (gzip)';
  }

  static String get _platform {
    if (io.Platform.isIOS) {
      return "IOS";
    }
    if (io.Platform.isAndroid) {
      return "ANDROID";
    }
    return "WEB";
  }
}
