import 'package:who_app/api/content/content_bundle.dart';
import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:who_app/api/content/schema/conditional_content.dart';

typedef QuestionIndexDataSource = Future<QuestionContent> Function(Locale);

/// Interpret a content bundle as Question data.
/// Question data contains a series of text-only title and body pairs.
class QuestionContent extends ContentBase {
  List<QuestionItem> items;

  QuestionContent(ContentBundle bundle) : super(bundle, schemaName: 'qa') {
    try {
      items = bundle.contentItems
          .map((item) => QuestionItem(
                title: item['title_html'],
                body: item['body_html'],
                displayCondition: item['display_condition'],
              ))
          .toList();
    } catch (err) {
      print('Error loading question data: $err');
      throw ContentBundleDataException();
    }
  }
}

/// Question and answer ('qa' schema) items including a title and body.
class QuestionItem with ConditionalItem {
  final String title;
  final String body;
  @override
  final String displayCondition;

  QuestionItem(
      {@required this.title, @required this.body, this.displayCondition});
}
