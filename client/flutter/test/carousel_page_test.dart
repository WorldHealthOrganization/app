import 'package:WHOFlutter/carousel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarouselSlide', () {
    testWidgets(
      'should display the message provided to it',
      (WidgetTester tester) async {
        final String message = 'test message';
        await tester.pumpWidget(
          MaterialApp(home: CarouselSlide(null, message: message)),
        );

        final Finder messageFinder = find.text(message);
        expect(messageFinder, findsOneWidget);
      },
    );

    testWidgets(
      'should display the titleWidget provided to it',
      (WidgetTester tester) async {
        final Key titleWidgetKey = ValueKey('titleWidgetKey');
        final Widget titleWidget = Icon(
          Icons.add,
          key: titleWidgetKey,
        );
        await tester.pumpWidget(
          MaterialApp(home: CarouselSlide(null, titleWidget: titleWidget)),
        );
        final Finder titleWidgetFinder = find.byKey(titleWidgetKey);
        expect(titleWidgetFinder, findsOneWidget);
      },
    );
  });

  group('CarouselView', () {
    testWidgets(
      'should display every CarouselSlide provided to it',
      (WidgetTester tester) async {
        final List<CarouselSlide> carouselSlideItems = [];

        /// Populates [carouselSlideItems]
        for (int i = 1; i <= 5; i++) {
          carouselSlideItems.add(CarouselSlide(null, message: '$i'));
        }

        await tester.pumpWidget(
          MaterialApp(home: CarouselView(carouselSlideItems)),
        );

        for (CarouselSlide carouselSlide in carouselSlideItems) {
          final Finder carouselSlideFinder = find.text(carouselSlide.message);

          // Expects to find the message provided to the CarouselSlider via a
          // CarouselSlide object
          expect(carouselSlideFinder, findsOneWidget);

          // Swipe to the next page so it's content can be found
          await tester.fling(find.byType(PageView), Offset(-100, 0), 800);
          await tester.pumpAndSettle();
        }
      },
    );
  });

  group('EmojiHeader', () {
    testWidgets(
      'should display the emoji string provided to it',
      (WidgetTester tester) async {
        final String emojiString = '😁';
        final Finder emojiStringFinder = find.text(emojiString);

        await tester.pumpWidget(MaterialApp(home: EmojiHeader(emojiString)));

        // Expects to find the emojiString provided to the EmojiHeader
        expect(emojiStringFinder, findsOneWidget);
      },
    );
  });
}
