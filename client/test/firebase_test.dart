import 'package:flutter_test/flutter_test.dart';
import 'package:who_app/main.dart';

void main() {
  test(
    'Firebase Emulator usage has been disabled',
    () {
      expect(
        USE_FIREBASE_LOCAL_EMULATORS,
        false,
      );
    },
  );
}
