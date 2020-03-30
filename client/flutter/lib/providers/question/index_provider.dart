import 'package:WHOFlutter/models/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum QuestionType {
  answered,
  whoMythBusters,
}

class QuestionIndexProvider with ChangeNotifier {
  final BuildContext context;
  final QuestionType type;

  List<Question> questions = [];

  QuestionIndexProvider({this.context, this.type}) {
    _fetch();
  }

  Future _fetch() async {
    switch (type) {
      case QuestionType.answered:
        questions = await QuestionViewModel.answered(this.context);

        break;

      case QuestionType.whoMythBusters:
        questions = await QuestionViewModel.mythbusters(this.context);

        break;
    }

    notifyListeners();
  }
}
