import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/api/content/content_loading.dart';
import 'dart:ui';
import 'package:meta/meta.dart';

typedef AdviceDataSource = Future<AdviceContent> Function(Locale);

/// Interpret a content bundle as Advice data.
/// Advice data contains banner text, a recommendation link and text,
/// and a series of advice items comprising text and image pairs.
class AdviceContent extends ContentBase {
  String banner;
  String body;
  List<AdviceItem> items;

  static Future<AdviceContent> travelAdvice(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "travel_advice");
    return AdviceContent(bundle);
  }

  AdviceContent(ContentBundle bundle) : super(bundle, schemaName: "advice") {
    try {
      this.banner = bundle.getString('banner') ?? "";
      this.body = bundle.getString('body') ?? "";
      this.items = bundle.contentItems
          .map((item) => AdviceItem(
                title: (item['title'] ?? "").trim(),
                body: (item['body'] ?? "").trim(), // remove trailing newline
              ))
          .toList();
    } catch (err) {
      print("Error loading fact data: $err");
      throw ContentBundleDataException();
    }
  }
}

/// Advice ('advice' schema) items including title and body text.
class AdviceItem {
  final String title;
  final String body;

  AdviceItem({
    @required this.title,
    @required this.body,
  });
}
