import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/screenshots.dart';
import 'package:test/test.dart';

void main() {
  group('WHO App', () {
    FlutterDriver driver;
    final config = Config();

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // Agree to getting started
      final getStartedButton = find.byValueKey('get_started_button');
      await driver.waitFor(getStartedButton);
      await driver.tap(getStartedButton);

      // Skip push notifications
      final skipPushButton = find.byValueKey('skip_button');
      await driver.waitFor(skipPushButton);
      await driver.tap(skipPushButton);

      // Skip location
      final skipLocationButton = find.byValueKey('skip_button');
      await driver.waitFor(skipLocationButton);
      await driver.tap(skipLocationButton);
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('take screenshots', () async {
      // Home tab
      final homeTab = find.byValueKey('home_tab');
      await driver.waitFor(homeTab);
      await driver.tap(homeTab);
      await screenshot(driver, config, '0');

      // Stats tab
      final statsTab = find.byValueKey('stats_tab');
      await driver.waitFor(statsTab);
      await driver.tap(statsTab);
      await screenshot(driver, config, '1');

      // Learn tab
      final learnTab = find.byValueKey('learn_tab');
      await driver.waitFor(learnTab);
      await driver.tap(learnTab);
      await screenshot(driver, config, '2');

      // Check-Up tab
      final checkUpTab = find.byValueKey('check_up_tab');
      await driver.waitFor(checkUpTab);
      await driver.tap(checkUpTab);
      await screenshot(driver, config, '3');

      // Settings tab
      final settingsTab = find.byValueKey('settings_tab');
      await driver.waitFor(settingsTab);
      await driver.tap(settingsTab);
      await screenshot(driver, config, '4');
    });
  });

}
