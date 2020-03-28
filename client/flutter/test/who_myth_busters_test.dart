import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  Widget testableWidget({Widget child}) {
    return MaterialApp(
      title: "WHO",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      locale: Locale('en', ''),
      supportedLocales: S.delegate.supportedLocales,
      home: child,
    );
  }

  testWidgets('WHO Myth Buster Page is rendered Properly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(testableWidget(child: WhoMythBusters()));
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
    await tester.pumpWidget(testableWidget(child: WhoMythBusters()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Performs Swipe Left action
    await tester.flingFrom(Offset(400, 400), Offset(-100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped left, we should be able to read the text of second page
    expect(
        find.text('People of all ages CAN be infected by the coronavirus. '
            'Older people, and people with pre-existing medical conditions (such as asthma, '
            'diabetes, heart disease) appear to be more vulnerable to becoming severely ill '
            'with the virus'),
        findsOneWidget);
    // Performs Swipe Right action
    await tester.flingFrom(Offset(400, 400), Offset(100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped right, we should be able to read the text of first page.
    expect(
        find.text(
            'There is a lot of false information around. These are the facts'),
        findsOneWidget);
  });
}
