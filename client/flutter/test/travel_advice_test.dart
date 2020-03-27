import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';

enum Direction { LEFT, RIGHT }

// Reusable swiping function.
void swipePageView(WidgetTester tester,
    [Direction direction = Direction.LEFT]) async {
  double horizontalOffset = direction == Direction.LEFT ? -100 : 100;
  await tester.fling(find.byType(PageView), Offset(horizontalOffset, 0), 800);
  await tester.pumpAndSettle();
}

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  Widget testableWidget({Widget child}) {
    return MaterialApp(
      title: "WHO",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      locale: Locale('en', ''),
      supportedLocales: S.delegate.supportedLocales,
      home: child,
    );
  }

  final List<String> pagesTexts = <String>[
    "WHO continues to advise against the application of travel or trade restrictions to countries experiencing COVID-19 outbreaks…",
    "It is prudent for travellers who are sick to delay or avoid travel to affected areas, in particular for elderly travellers and people with chronic diseases or underlying health conditions…",
    "“Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contrast to areas reporting only imported cases…",
    "General recommendations for all travellers include…",
    "Wash your hands frequently",
    "Avoid touching your eyes, mouth and nose",
    "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze",
    "Stay more than 1 meter (3 feet) away from a person who is sick",
    "Follow proper food hygiene practices",
    "Only wear a mask if you are ill with COVID-19 symptoms (especially coughing) or looking after someone who may have COVID-19",
    "Travellers returning from affected areas should:",
    "Self-monitor for symptoms for 14 days and follow national protocols of receiving countries. Some countries may require returning travellers to enter quarantine",
    "Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus",
    "If symptoms occur, such as fever, or cough or difficulty breathing, travellers are advised to contact local health care providers, preferably by phone, and inform them of their symptoms and their travel history",
  ];
  testWidgets('WHO Travel Advice page is rendered Properly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(testableWidget(child: TravelAdvice()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(pagesTexts[0]), findsOneWidget);
  });

  testWidgets('WHO Travel Advice page carousel is working correctly',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(testableWidget(child: TravelAdvice()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Performs Swipe Left action
    await swipePageView(tester, Direction.LEFT);
    // Once we have swiped left, we should be able to read the text of second page
    expect(find.text(pagesTexts[1]), findsOneWidget);
    // Performs Swipe Right action
    await swipePageView(tester, Direction.RIGHT);
    // Once we have swiped right, we should be able to read the text of first page.
    expect(find.text(pagesTexts.first), findsOneWidget);
    // Performs Swipe Right action
    await swipePageView(tester, Direction.RIGHT);
    // Once we have swiped right again, the page should not change as it is the first page.
    expect(find.text(pagesTexts.first), findsOneWidget);
  });
  testWidgets('WHO Travel Advice page carousel has the correct content',
      (WidgetTester tester) async {
    // Increasing the default viewport size to avoid RenderFlex overflow error
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(testableWidget(child: TravelAdvice()));
    await tester.pumpAndSettle(Duration(seconds: 1));
    // Check all content of all pages
    for (String pageText in pagesTexts) {
      expect(find.text(pageText), findsOneWidget);
      await swipePageView(tester, Direction.LEFT);
    }
    // Swiping left on the last page should not change the page.
    expect(find.text(pagesTexts.last), findsOneWidget);
  });
}
