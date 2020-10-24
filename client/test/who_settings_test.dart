import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/pages/about_page.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  Widget testableWidget({Widget child}) {
    return CupertinoApp(
      title: 'WHO',
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

  testWidgets(
    'WHO About Page is rendering its PageHeader properly',
    (WidgetTester tester) async {
      // Increasing the default viewport size to avoid RenderFlex overflow error
      await binding.setSurfaceSize(Size(800, 800));
      await tester.pumpWidget(
        testableWidget(
          child: AboutPage(),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text(
          'About the App',
        ),
        findsWidgets,
      );
    },
  );
}
