import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:WHOFlutter/carousel_page.dart';

void main() {
  testWidgets('Carousel slide does not overflow with long text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CarouselSlide(
          titleWidget: EmojiHeader('A'),
          message: 'A very long string ' * 1000,
        ),
      ),
    );

    expect(find.byType(CarouselSlide), findsOneWidget);
  });

  testWidgets('Carousel slide with long text can be scrolled',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CarouselSlide(
          titleWidget: SizedBox(height: 1000),
          message: 'the end',
        ),
      ),
    );

    expect(find.byType(CarouselSlide), findsOneWidget);
    expect(find.text('the end').hitTestable(), findsNothing);

    await tester.drag(find.byType(CarouselSlide), Offset(0, -1000));
    expect(find.text('the end').hitTestable(), findsOneWidget);
  });
}
