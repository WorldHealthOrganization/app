import 'dart:async';

import 'package:flutter/services.dart';

class GetProxy {
  static const MethodChannel _channel = MethodChannel('get_proxy');

  static Future<String> get getProxy async {
    var proxy = await _channel.invokeMethod('getProxy');
    return proxy;
  }
}
