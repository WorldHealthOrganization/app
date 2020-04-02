import 'package:WHOFlutter/api/question_data.dart';
import 'package:WHOFlutter/models/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum QuestionIndexType {
  yourQuestionsAnswered,
  whoMythbusters,
}

class QuestionIndexProvider with ChangeNotifier {
  final BuildContext context;
  final QuestionIndexType type;

  List<Question> questions = [];

  QuestionIndexProvider({this.context, this.type}) {
    _fetch();
  }

  Future _fetch() async {
    switch (type) {
      case QuestionIndexType.yourQuestionsAnswered:
        questions = await QuestionData.yourQuestionsAnswered(context);

        break;

      case QuestionIndexType.whoMythbusters:
        questions = await QuestionData.whoMythbusters(context);

        break;
    }

    notifyListeners();
  }
}
