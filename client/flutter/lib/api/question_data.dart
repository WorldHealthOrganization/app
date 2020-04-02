import 'package:WHOFlutter/api/content_loading.dart';
import 'package:WHOFlutter/models/question.dart';
import 'package:flutter/cupertino.dart';

class QuestionData {
  static Future<List<Question>> yourQuestionsAnswered(
      BuildContext context) async {
    return _load(context, "your_questions_answered");
  }

  static Future<List<Question>> whoMythbusters(BuildContext context) async {
    return _load(context, "mythbusters");
  }

  /// Load a content bundle and interpret it as question data.
  static Future<List<Question>> _load(BuildContext context, String name) async {
    try {
      var bundle = await ContentLoading().load(context, name);

      if (bundle.contentType != "qa") {
        throw Exception("Unrecognized content type: ${bundle.contentType}");
      }

      return bundle.contents
          .map((item) =>
              Question(title: item['title_html'], body: item['body_html']))
          .toList();
    } catch (err) {
      print("Error loading question data: $err");
      return [];
    }
  }
}
