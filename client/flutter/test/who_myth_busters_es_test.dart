import 'package:WHOFlutter/generated/intl/messages_es_ES.dart';
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

  final Locale locale = Locale('es', 'ES');

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

  testWidgets('WHO Myth Buster Page is rendered Properly (es_ES)',
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

  testWidgets('WHO Myth-buster page carousel is working correctly (es_ES)',
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

  testWidgets('WHO Myth Buster Page is rendered Properly (es)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester
        .pumpWidget(testableWidget(child: WhoMythBusters(), locale: Locale('es')));
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

  testWidgets('WHO Myth-buster page carousel is working correctly (es)',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester
        .pumpWidget(testableWidget(child: WhoMythBusters(), locale: Locale('es')));
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
