import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_proxy/get_proxy.dart';

void main() {
  const MethodChannel channel = MethodChannel('get_proxy');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GetProxy.platformVersion, '42');
  });
}
