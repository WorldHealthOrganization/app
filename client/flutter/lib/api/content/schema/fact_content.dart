import 'package:who_app/api/content/content_bundle.dart';
import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:who_app/api/content/content_loading.dart';

typedef FactsDataSource = Future<FactContent> Function(Locale);

/// Interpret a content bundle as Fact data.
/// Fact data contains a series of title and body pairs each with an associated
/// image or animation.
class FactContent extends ContentBase {
  List<FactItem> items;

  static Future<FactContent> getTheFacts(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "get_the_facts");
    return FactContent(bundle);
  }

  static Future<FactContent> protectYourself(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "protect_yourself");
    return FactContent(bundle);
  }

  FactContent(ContentBundle bundle) : super(bundle, schemaName: "fact") {
    try {
      this.items = bundle.contentItems
          .map((item) => FactItem(
              title: item['title_html'],
              body: item['body_html'],
              imageName: item['image_name'],
              animationName: item['animation_name']))
          .toList();
    } catch (err) {
      print("Error loading fact data: $err");
      throw ContentBundleDataException();
    }
  }
}

/// Fact ('fact' schema) items including a title, body, and optional image or
/// animation name referencing a local asset.
class FactItem {
  final String title;
  final String body;
  final String imageName;
  final String animationName;

  FactItem(
      {@required this.title,
      @required this.body,
      this.imageName,
      this.animationName});
}
