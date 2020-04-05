import 'dart:convert';
import 'package:WHOFlutter/api/endpoints.dart';
import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class WhoService {
  static final String serviceUrlStaging = '${Endpoints.STAGING}/WhoService';
  static final String serviceUrlProd = '${Endpoints.PROD}/WhoService';
  static final String serviceUrl = serviceUrlProd;

  /// Put device token.
  static Future<bool> putDeviceToken(String token) async {
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
  static Future<bool> putLocation({double latitude, double longitude, String countryCode, String adminArea, String subadminArea, String locality}) async {
    Map<String, String> headers = await _getHeaders();
    var postBody = jsonEncode({
      "latitude": latitude,
      "longitude": longitude,
      "countryCode": countryCode,
      "adminArea": adminArea,
      "subadminArea": subadminArea,
      "locality": locality,
    });
    print(postBody);
    var url = '$serviceUrl/putLocation';
    var response = await http.post(url, headers: headers, body: postBody);
    if (response.statusCode != 200) {
      throw Exception("Error status code: ${response.statusCode}");
    }
    return true;
  }


  static Future<Map<String,dynamic>> getCaseStats() async {
    Map<String, String> headers = await _getHeaders();
    var url = '$serviceUrl/getCaseStats';
    var response = await http.post(url, headers: headers, body: '');
    if (response.statusCode != 200) {
      throw Exception("Error status code: ${response.statusCode}");
    }
    // TODO: Should use protobuf.
    return jsonDecode(response.body);
  }

  static Future<Map<String, String>> _getHeaders() async {
    var clientId = await UserPreferences().getClientUuid();
    var headers = {
      'Content-Type': 'application/json',
      'Who-Client-ID': clientId,
      'Who-Platform': _platform
    };
    return headers;
  }

  static String get _platform {
    if (Platform.isIOS) {
      return "IOS";
    }
    if (Platform.isAndroid) {
      return "ANDROID";
    }
    return "WEB";
  }
}

