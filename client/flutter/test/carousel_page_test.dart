import 'package:WHOFlutter/carousel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('page changing', () {
    testWidgets('can change page via chevrons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CarouselView(
          <CarouselSlide>[
            CarouselSlide(message: 'page 1'),
            CarouselSlide(message: 'page 2'),
            CarouselSlide(message: 'page 3'),
          ]
        ),
      ));

      // Can't go back from page 1. No left chevron.
      expect(find.byIcon(Icons.chevron_left), findsNothing);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.text('page 1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      // Both chevrons are present on page 2.
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.text('page 2'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      // Can't go forward any further on last page.
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNothing);
      expect(find.text('page 3'), findsOneWidget);

      // Check that going back works too.
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.text('page 2'), findsOneWidget);
    });
  });
}
