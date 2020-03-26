import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WHOFlutter/main.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WHO Myth Buster Page is rendered Properly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Navigate to WHO Myth Buster Page
    await tester.tap(find.text('WHO Myth-busters'));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'There is a lot of false information around. These are the facts'),
        findsOneWidget);
  });

  testWidgets('WHO Myth-buster page carousel is working correctly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text('WHO Myth-busters'));
    await tester.pumpAndSettle();
    // Performs Swipe Left action
    await tester.fling(find.byType(PageView), Offset(-100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped left, we should be able to read the text of second page
    expect(
        find.text('People of all ages CAN be infected by the coronavirus. '
            'Older people, and people with pre-existing medical conditions (such as asthma, '
            'diabetes, heart disease) appear to be more vulnerable to becoming severely ill '
            'with the virus'),
        findsOneWidget);
    // Performs Swipe Right action
    await tester.fling(find.byType(PageView), Offset(100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped right, we should be able to read the text of first page.
    expect(
        find.text(
            'There is a lot of false information around. These are the facts'),
        findsOneWidget);
  });
}
