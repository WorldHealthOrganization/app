import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home Page Renders Correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: "WHO",
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        locale: Locale('en', ''),
        supportedLocales: S.delegate.supportedLocales,
        home: HomePage(),
      ),
    );

    // Delay to load the text from Localization
    await tester.pumpAndSettle(Duration(seconds: 1));

    // Expects the WHO logo displayed on the top
    expect(find.byType(Image), findsOneWidget);

    expect(find.text('Protect yourself'), findsOneWidget);
    expect(find.text('Latest \nNumbers'), findsOneWidget);
    expect(find.text('Your \nQuestions \nAnswered'), findsOneWidget);

    // Scroll to the bottom
    await tester.flingFrom(Offset(300, 300), Offset(0, -1000), 800);
    await tester.pumpAndSettle();

    expect(find.text('WHO Myth-busters'), findsOneWidget);
    expect(find.text('Travel Advice'), findsOneWidget);
    expect(find.text('Share The App'), findsOneWidget);
    expect(find.text('Provide app feedback'), findsOneWidget);
    expect(find.text('About the app'), findsOneWidget);
  });
}
