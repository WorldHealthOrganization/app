import 'package:who_app/api/content/content_bundle.dart';
import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:who_app/api/content/schema/conditional_content.dart';

typedef AdviceDataSource = Future<AdviceContent> Function(Locale);

/// Interpret a content bundle as Advice data.
/// Advice data contains banner text, a recommendation link and text,
/// and a series of advice items comprising text and image pairs.
class AdviceContent extends ContentBase {
  List<AdviceItem> items;

  AdviceContent(ContentBundle bundle) : super(bundle, schemaName: 'advice') {
    try {
      items = bundle.contentItems
          .map((item) => AdviceItem(
                isBanner: item['is_banner'] ?? false,
                title: (item['title'] ?? '').trim(),
                body: (item['body'] ?? '').trim(), // remove trailing newline
                displayCondition: item['display_condition'],
              ))
          .toList();
    } catch (err) {
      print('Error loading fact data: $err');
      throw ContentBundleDataException();
    }
  }
}

/// Advice ('advice' schema) items including title and body text.
class AdviceItem with ConditionalItem {
  final String title;
  final String body;
  @override
  final String displayCondition;
  final bool isBanner;

  AdviceItem({
    @required this.title,
    @required this.body,
    this.isBanner,
    this.displayCondition,
  });
}
