import 'package:WHOFlutter/generated/intl/messages_zh_CN.dart';
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

  final Locale locale = Locale('zh', 'CN');

  Widget testableWidget({Widget child, Locale locale}) {
    return MaterialApp(
      title: "WHO",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      home: child,
    );
  }

  testWidgets('WHO Myth Buster Page is rendered Properly (zh_CN)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester
        .pumpWidget(testableWidget(child: WhoMythBusters(), locale: locale));
    await tester.pumpAndSettle();
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem1',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
  });

  testWidgets('WHO Myth-buster page carousel is working correctly (zh_CN)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester
        .pumpWidget(testableWidget(child: WhoMythBusters(), locale: locale));
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Performs Swipe Left action
    await tester.flingFrom(Offset(400, 400), Offset(-100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped left, we should be able to read the text of second page
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem2',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
    // Performs Swipe Right action
    await tester.flingFrom(Offset(400, 400), Offset(100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped right, we should be able to read the text of first page.
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem1',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
  });

  testWidgets('WHO Myth Buster Page is rendered Properly (fr)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester
        .pumpWidget(testableWidget(child: WhoMythBusters(), locale: Locale('zh')));
    await tester.pumpAndSettle();
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem1',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
  });

  testWidgets('WHO Myth-buster page carousel is working correctly (fr)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester
        .pumpWidget(testableWidget(child: WhoMythBusters(), locale: Locale('zh')));
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Performs Swipe Left action
    await tester.flingFrom(Offset(400, 400), Offset(-100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped left, we should be able to read the text of second page
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem2',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
    // Performs Swipe Right action
    await tester.flingFrom(Offset(400, 400), Offset(100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped right, we should be able to read the text of first page.
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem1',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
  });

  testWidgets('WHO Myth Buster Page is rendered Properly (zh_TW)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(
        testableWidget(child: WhoMythBusters(), locale: Locale('zh', 'TW')));
    await tester.pumpAndSettle();
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem1',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
  });

  testWidgets('WHO Myth-buster page carousel is working correctly (zh_TW)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(
        testableWidget(child: WhoMythBusters(), locale: Locale('zh', 'TW')));
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Performs Swipe Left action
    await tester.flingFrom(Offset(400, 400), Offset(-100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped left, we should be able to read the text of second page
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem2',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
    // Performs Swipe Right action
    await tester.flingFrom(Offset(400, 400), Offset(100, 0), 800);
    await tester.pumpAndSettle();
    // Once we have swiped right, we should be able to read the text of first page.
    expect(
        find.text(MessageLookup().lookupMessage(
            'whoMythBustersListOfItemsPageListItem1',
            locale.toLanguageTag(),
            null,
            null,
            null)),
        findsOneWidget);
  });
}
