import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WHOFlutter/generated/l10n.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  Widget testableWidget() {
    return MaterialApp(
      title: "WHO",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      locale: Locale('en', ''),
      supportedLocales: S.delegate.supportedLocales,
      home: ProtectYourself(),
    );
  }

  testWidgets('ProtectYourself page is rendered Properly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(testableWidget());
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Wash your hands with soap and running water frequently'),
        findsOneWidget);
  });

  testWidgets('ProtectYourself page carousel is working correctly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(testableWidget());
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Performs Swipe Left action
    await tester.fling(find.byType(PageView), Offset(-100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped left, we should be able to read the text of second page
    expect(
        find.text('Avoid touching your eyes, mouth, and nose'), findsOneWidget);
    // Performs Swipe Right action
    await tester.fling(find.byType(PageView), Offset(500, 0), 800);
    await tester.pump();
    // Once we have swiped right, we should be able to read the text of first page.
    expect(find.text('Wash your hands with soap and running water frequently'),
        findsOneWidget);
  });
}
