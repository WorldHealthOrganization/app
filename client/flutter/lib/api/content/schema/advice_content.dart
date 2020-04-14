import 'package:WHOFlutter/api/content/content_bundle.dart';
import 'package:flutter/cupertino.dart';
import '../content_loading.dart';

typedef AdviceDataSource = Future<AdviceContent> Function(Locale);

/// Interpret a content bundle as Advice data.
/// Advice data contains banner text, a recommendation link and text,
/// and a series of advice items comprising text and image pairs.
class AdviceContent extends ContentBase {
  String banner;
  String recommendations;
  String recommendationsLink;
  List<AdviceItem> items;

  static Future<AdviceContent> travelAdvice(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "travel_advice");
    return AdviceContent(bundle);
  }

  AdviceContent(ContentBundle bundle) : super(bundle, schemaName: "advice") {
    try {
      this.banner = bundle.getString('banner_html') ?? "";
      this.recommendations = bundle.getString('recommendations_html') ?? "";
      this.recommendationsLink =
          bundle.getString('recommendations_link') ?? "https://www.who.int";
      this.items = bundle.contentItems
          .map((item) => AdviceItem(
                imageName: item['image_name'],
                body:
                    (item['body_html'] ?? "").trim(), // remove trailing newline
              ))
          .toList();
    } catch (err) {
      print("Error loading fact data: $err");
      throw ContentBundleDataException();
    }
  }
}

/// Advice ('advice' schema) items including body text and an image name
/// referencing a local asset.
class AdviceItem {
  final String imageName;
  final String body;

  AdviceItem({
    @required this.body,
    this.imageName,
  });
}
