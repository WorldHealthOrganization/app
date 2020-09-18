import 'package:flutter_test/flutter_test.dart';
import 'package:who_app/api/iso_country.dart';

void main() {
  group('iso_country', () {
    test('emoji', () {
      expect(
          IsoCountry(alpha2Code: 'US', name: 'does not matter').emoji, '🇺🇸');
      expect(
          IsoCountry(alpha2Code: 'NG', name: 'does not matter').emoji, '🇳🇬');
      expect(
          IsoCountry(alpha2Code: 'CH', name: 'does not matter').emoji, '🇨🇭');
    });
  });
}
