import 'package:WHOFlutter/listViewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListItem', () {
    testWidgets(
      'should display the message provided to it',
      (WidgetTester tester) async {
        final String message = 'test message';
        await tester.pumpWidget(
          MaterialApp(home: ListItem(message: message)),
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
          MaterialApp(home: ListItem(titleWidget: titleWidget)),
        );
        final Finder titleWidgetFinder = find.byKey(titleWidgetKey);
        expect(titleWidgetFinder, findsOneWidget);
      },
    );
  });

  group('ListOfItemsPage', () {
    testWidgets(
      'should display every ListItem provided to it',
      (WidgetTester tester) async {
        final List<ListItem> listItems = [];

        /// Populates [listItems]
        for (int i = 1; i <= 5; i++) {
          listItems.add(ListItem(message: '$i'));
        }

        await tester.pumpWidget(
          MaterialApp(home: ListOfItemsPage(listItems)),
        );

        for (ListItem listItem in listItems) {
          final Finder listItemFinder = find.text(listItem.message);

          // Expects to find the message provided to the ListItem
          expect(listItemFinder, findsOneWidget);
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
