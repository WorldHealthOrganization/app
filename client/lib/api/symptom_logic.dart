import 'package:flutter/material.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';
import 'package:who_app/api/display_conditions.dart';

///
/// Condition expressions may use bool and int literals, and the following
/// names (where questionId is the id of any prior question and
/// answerId is any answer id in that question):
/// - wasDisplayed("<questionId>") - whether a prior question was displayed
/// - has("<answerId>") - true iff any answer with that id was selected
///
/// The following are defined solely if the question was displayed
/// (conditions must not rely on answers to questions that may not have been
/// displayed):
/// - int : selectionCount("<questionId>") - the number of answers selected for
///       the given question (0 for none of the above)
/// - bool : <questionId>["<answerId>"] - whether or not the given answer
///       was selected.
///
/// Conditions may use any of the following operators:
/// - bool || && !
/// - bitwise | & ^ << >> ~
/// - equality == != <= >= < >
/// - arithmetic + - * / %
///
class SymptomLogic {
  Map<String, dynamic> _pageToContext(SymptomCheckerPageModel m) {
    final ret = <String, dynamic>{};
    ret[m.question.id] = <String, bool>{};
    m.question.answers.forEach((answer) {
      ret[m.question.id][answer.id] = m.selectedAnswers.contains(answer.id);
    });
    return Map.unmodifiable(ret);
  }

  Map<String, dynamic> pagesToContext(
      List<SymptomCheckerPageModel> previousPages) {
    final ret = <String, dynamic>{
      'wasDisplayed': (String qId) =>
          previousPages.any((p) => p.question.id == qId),
      'selectionCount': (String qId) => previousPages
          .firstWhere((p) => p.question.id == qId)
          .selectedAnswers
          .length,
      'has': (String aId) =>
          previousPages.any((p) => p.selectedAnswers.contains(aId)),
    };
    previousPages.forEach((m) {
      ret.addAll(_pageToContext(m));
    });
    return Map.unmodifiable(ret);
  }

  bool evaluateCondition(
      {@required String condition,
      @required LogicContext context,
      @required List<SymptomCheckerPageModel> previousPages}) {
    final pagesContext = pagesToContext(previousPages);
    return Logic().evaluateCondition(
        condition: condition, context: context, extra: pagesContext);
  }
}
