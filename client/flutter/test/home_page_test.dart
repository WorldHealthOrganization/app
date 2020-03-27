import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WHOFlutter/main.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Home Page Renders Correctly', (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 640));
    await tester.pumpWidget(MyApp());
    // Delay to load the text from Localization
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Expects the WHO logo displayed on the top
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Protect yourself'), findsOneWidget);
    expect(find.text('WHO Myth-busters'), findsOneWidget);
    expect(find.text('Travel Advice'), findsOneWidget);
    expect(find.text('Share the App'), findsOneWidget);
    expect(find.text('About the App'), findsOneWidget);
  });

  testWidgets('WHO Myth-busters navigation works correctly',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(800, 640));
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text('Protect yourself'));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Wash your hand often with soap and running water frequently'),
        findsOneWidget);
  });

  testWidgets('Protect yourself navigation works correctly',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(800, 640));
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text('WHO Myth-busters'));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'There is a lot of false information around. These are the facts'),
        findsOneWidget);
  });

  testWidgets('Travel Advice navigation works correctly',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(800, 640));
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text('Travel Advice'));
    await tester.pumpAndSettle();
    expect(
        find.text('WHO continues to advise against the application of '
            'travel or trade restrictions to countries experiencing'
            ' COVID-19 outbreaks…'),
        findsOneWidget);
  });

  testWidgets('Clicking on About App shows showDialog',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(800, 640));
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(Duration(seconds: 1));
    await tester.tap(find.text('About the App'));
    expect(find.byType(AboutDialog), findsNothing);
    await tester.pumpAndSettle();
    expect(find.byType(AboutDialog), findsOneWidget);
    expect(
        tester
            .widget<AboutDialog>(find.byType(AboutDialog))
            .applicationLegalese,
        'The official World Health Organization COVID-19 App.');
  });
}
