import 'package:flutter/cupertino.dart';
import 'package:who_app/api/symptom_logic.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

/// Analyze the completed model and show the results.
class SymptomCheckerSummary extends StatelessWidget {
  final SymptomCheckerModel model;

  const SymptomCheckerSummary({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(model.isComplete);
    // TODO: Put the results in a content bundle, with conditions.
    final r = SymptomLogic().pagesToContext(model.pages).toString();
    return Text("Answers: " + r);
  }
}
