import 'package:WHOFlutter/api/content_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Question {
  String title;
  String body;

  Question({@required this.title, @required this.body});
}

/// This is just a *placeholder* for the dynamic content.
class QuestionViewModel {
  static Future<List<Question>> answered(
    BuildContext context,
  ) async {
    try {
      final bundle = await ContentLoading().load(
        context,
        "your_questions_answered",
      );

      return bundle.contents
          .map(
            (item) => Question(
              title: item['title_html'],
              body: item['body_html'],
            ),
          )
          .toList();
    } catch (err) {
      print("Error loading question data: $err");
      return [];
    }
  }

  static Future<List<Question>> mythbusters(BuildContext context) async {
    // TODO: Wrong data!!!
    return answered(context);
  }
}
