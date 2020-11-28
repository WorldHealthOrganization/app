
import 'dart:async';

import 'package:flutter/services.dart';

class GetProxy {

  static const MethodChannel _channel =
      const MethodChannel('get_proxy');

  static Future<String> get getProxy async {
    final String proxy = await _channel.invokeMethod('getProxy');
    return proxy;
  }
}
