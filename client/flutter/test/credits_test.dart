import 'package:WHOFlutter/pages/credits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Credits lists are fetched and displayed correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DefaultAssetBundle(
        bundle: _TestAssetBundle(),
        child: const Contributors(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Peter Singer'), findsOneWidget);
    expect(find.text('Sam Mousa'), findsOneWidget);
    expect(find.text('creativecreatorormaybenot'), findsOneWidget);
  });
}

class _TestAssetBundle extends AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    assert(key == '../../content/credits.yaml');

    // This is only used for testing, which is why this is only an excerpt of the actual file.
    return '''
team:
  - Peter Singer
  - Sam Mousa
  - creativecreatorormaybenot

supporters: [] 
''';
  }

  @override
  Future<ByteData> load(String key) {
    throw UnimplementedError();
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    throw UnimplementedError();
  }
}
