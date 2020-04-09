import 'package:WHOFlutter/api/content/content_loading.dart';
import 'package:flutter/cupertino.dart';

class DynamicContent {
  static Future<List<QuestionItem>> yourQuestionsAnswered(
      BuildContext context) async {
    return _loadQuestionItems(context, "your_questions_answered");
  }

  static Future<List<FactItem>> getTheFacts(BuildContext context) async {
    return _loadFactItems(context, "get_the_facts");
  }

  /// Load a content bundle and interpret it as question data.
  static Future<List<QuestionItem>> _loadQuestionItems(
      BuildContext context, String name) async {
    try {
      var bundle = await ContentLoading().load(context, name);

      if (bundle.contentType != "qa") {
        throw Exception("Unrecognized content type: ${bundle.contentType}");
      }

      return bundle.contents
          .map((item) =>
              QuestionItem(title: item['title_html'], body: item['body_html']))
          .toList();
    } catch (err) {
      print("Error loading question data: $err");
      return [];
    }
  }

  /// Load a content bundle and interpret it as fact data.
  static Future<List<FactItem>> _loadFactItems(
      BuildContext context, String name) async {
    try {
      var bundle = await ContentLoading().load(context, name);

      // "Just the Facts. Ma'am"
      if (bundle.contentType != "fact") {
        throw Exception("Unrecognized content type: ${bundle.contentType}");
      }

      return bundle.contents
          .map((item) => FactItem(
              title: item['title_html'],
              body: item['body_html'],
              imageName: item['image_name']))
          .toList();
    } catch (err) {
      print("Error loading question data: $err");
      return [];
    }
  }
}

class QuestionItem {
  String title;
  String body;

  QuestionItem({@required this.title, @required this.body});
}

class FactItem {
  String title;
  String body;
  String imageName;

  FactItem(
      {@required this.title, @required this.body, @required this.imageName});
}

