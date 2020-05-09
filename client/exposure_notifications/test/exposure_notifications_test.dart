import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exposure_notifications/exposure_notifications.dart';

void main() {
  const MethodChannel channel = MethodChannel('exposure_notifications');

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
    expect(await ExposureNotifications.platformVersion, '42');
  });
}
