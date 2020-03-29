import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/home_page.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/question_index.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("$HomePage integration tests", () {
    final translations = S('en_US');
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    const surfaceSize = Size(800, 1800);

    Widget sut() => MaterialApp(
          title: "WHO",
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate,
          ],
          locale: Locale('en', ''),
          supportedLocales: S.delegate.supportedLocales,
          home: HomePage(),
        );

    testWidgets('Navigate to and back from $ProtectYourself', (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(sut());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ProtectYourself), findsNothing);

      await tester.tap(find.widgetWithText(
          PageButton, translations.homePagePageButtonProtectYourself));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(ProtectYourself), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ProtectYourself), findsNothing);
    });

    testWidgets('Navigate to and back from $ProtectYourself', (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(sut());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ProtectYourself), findsNothing);

      await tester.tap(find.widgetWithText(
          PageButton, translations.homePagePageButtonProtectYourself));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(ProtectYourself), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ProtectYourself), findsNothing);
    });

    testWidgets('Tapping Your questions answered will show $QuestionIndexPage',
        (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(sut());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(QuestionIndexPage), findsNothing);

      await tester.tap(find.widgetWithText(
          PageButton, translations.homePagePageButtonYourQuestionsAnswered));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(QuestionIndexPage), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(QuestionIndexPage), findsNothing);
    });

    testWidgets('Navigate to and back from $WhoMythBusters', (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(sut());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(WhoMythBusters), findsNothing);

      await tester.tap(find.widgetWithText(
          PageButton, translations.homePagePageButtonWHOMythBusters));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(WhoMythBusters), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(WhoMythBusters), findsNothing);
    });

    testWidgets('Navigate to and from $TravelAdvice', (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(sut());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(TravelAdvice), findsNothing);

      await tester.tap(find.widgetWithText(
          PageButton, translations.homePagePageButtonTravelAdvice));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(TravelAdvice), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(TravelAdvice), findsNothing);
    });

    testWidgets('Open and close $AboutDialog', (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(sut());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(AboutDialog), findsNothing);

      await tester.tap(find.widgetWithText(
          ListTile, translations.homePagePageSliverListAboutTheApp));
      await tester.pumpAndSettle();

      expect(find.byType(AboutDialog), findsOneWidget);

      final MaterialLocalizations materialLocalizations =
          MaterialLocalizations.of(tester.element(find.byType(AboutDialog)));
      await tester.tap(find.widgetWithText(
          FlatButton, materialLocalizations.closeButtonLabel));
      await tester.pumpAndSettle();

      expect(find.byType(AboutDialog), findsNothing);
    });

    testWidgets('Navigating to $LicensePage from $AboutDialog', (tester) async {
      await binding.setSurfaceSize(surfaceSize);
      await tester.pumpWidget(RepaintBoundary(child: sut()));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      await tester.tap(find.widgetWithText(
          ListTile, translations.homePagePageSliverListAboutTheApp));
      await tester.pumpAndSettle();

      expect(find.byType(AboutDialog), findsOneWidget);

      final MaterialLocalizations materialLocalizations =
          MaterialLocalizations.of(tester.element(find.byType(AboutDialog)));
      await tester.tap(find.widgetWithText(
          FlatButton, materialLocalizations.viewLicensesButtonLabel));
      await tester.pumpAndSettle();

      expect(find.byType(LicensePage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(AboutDialog), findsNothing);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(AboutDialog), findsOneWidget);
    });
  });
}
