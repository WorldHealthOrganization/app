import 'package:who_app/api/content/content_bundle.dart';
import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:who_app/api/content/schema/conditional_content.dart';

typedef FactsDataSource = Future<FactContent> Function(Locale);

/// Interpret a content bundle as Fact data.
/// Fact data contains a series of title and body pairs each with an associated
/// image or animation.
class FactContent extends ContentBase {
  List<FactItem> items;

  FactContent(ContentBundle bundle) : super(bundle, schemaName: 'fact') {
    try {
      items = bundle.contentItems
          .map((item) => FactItem(
                title: item['title_html'],
                body: item['body_html'],
                imageName: item['image_name'],
                animationName: item['animation_name'],
                displayCondition: item['display_condition'],
              ))
          .toList();
    } catch (err) {
      print('Error loading fact data: $err');
      throw ContentBundleDataException();
    }
  }
}

/// Fact ('fact' schema) items including a title, body, and optional image or
/// animation name referencing a local asset.
class FactItem with ConditionalItem {
  final String title;
  final String body;
  final String imageName;
  final String animationName;
  @override
  final String displayCondition;

  FactItem(
      {@required this.title,
      @required this.body,
      this.imageName,
      this.animationName,
      this.displayCondition});
}
