import 'package:flutter_test/flutter_test.dart';

import 'package:WHOFlutter/main.dart';

void main() {
  testWidgets('App Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });
}
