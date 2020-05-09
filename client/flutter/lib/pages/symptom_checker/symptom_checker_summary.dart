import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/symptom_checker/question_pages/yes_no_question_view.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

/// Analyze the completed model and show the results.
class SymptomCheckerSummary extends StatelessWidget {
  final SymptomCheckerModel model;

  const SymptomCheckerSummary({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(model.isComplete);

    // TODO: We can generate a dart API for the questions and answer ids.

    // Check a specific answer condition
    var c1 = model['question_1'].answered(YesNoQuestionView.YES);

    // Check for any of multiple specific answers
    var c2 = model['question_2'].answeredAny({'answer_1', 'answer_2'});

    // Check for all of multiple specific answers
    var c3 = model['question_2'].answeredAll({'answer_1', 'answer_2'});

    // Note: We should support "tags" to generalize this.

    return (c1 || c2 || c3)
        ? Text("Answers matched conditions!")
        : Text("No conditions met.");
  }
}
