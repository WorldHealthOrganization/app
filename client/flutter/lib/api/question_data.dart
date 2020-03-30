import 'package:WHOFlutter/api/content_loading.dart';
import 'package:flutter/cupertino.dart';

class QuestionData {
  static Future<List<QuestionItem>> yourQuestionsAnswered(
      BuildContext context) async {
    try {
      var bundle =
          await ContentLoading().load(context, "your_questions_answered");
      return bundle.contents
          .map((item) =>
              QuestionItem(title: item['title_html'], body: item['body_html']))
          .toList();
    } catch (err) {
      print("Error loading question data: $err");
      return [];
    }
  }

  static Future<List<QuestionItem>> whoMythbusters(BuildContext context) async {
    // TODO: Wrong data!!!
    return yourQuestionsAnswered(context);
  }
}

class QuestionItem {
  String title;
  String body;

  QuestionItem({@required this.title, @required this.body});
}
