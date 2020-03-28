import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WHOFlutter/generated/l10n.dart';

void main() {
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

  testWidgets('ProtectYourself Page is rendered Properly',
      (WidgetTester tester) async {
    await tester.pumpWidget(testableWidget());
    await tester.pumpAndSettle();

    expect(find.text('Wash your hands with soap and running water frequently'),
        findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
  });

  testWidgets('ProtectYourself page Sliver List is working correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(testableWidget());
    await tester.pumpAndSettle();

    // Performs Scroll up action
    await tester.flingFrom(Offset(400, 400), Offset(0, -400), 800);
    await tester.pumpAndSettle();

    // Once we have scrolled up, we should be able to read the first text
    expect(find.text('Wash your hands with soap and running water frequently'),
        findsNothing);

    // Performs Scroll down action
    await tester.flingFrom(Offset(400, 400), Offset(0, 400), 800);
    await tester.pumpAndSettle();

    // Once we have scrolled down, we should be able to read the first text.
    expect(find.text('Wash your hands with soap and running water frequently'),
        findsOneWidget);
  });
}
