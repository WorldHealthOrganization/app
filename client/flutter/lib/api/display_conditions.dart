import 'package:expressions/expressions.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:who_app/api/user_preferences.dart';

import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

class LogicContext {
  /// alpha-2 code
  final String isoCountryCode;

  /// Consistent value in [0-100) for experiment arms
  final int cohort;

  /// ISO 8601 date and time, ex 2017-09-05T14:49Z
  final String isoDateTimeUTC;

  /// Local days completed since Jan 1, 2020
  final int localDays;

  LogicContext(
      {@required this.isoCountryCode,
      @required this.cohort,
      @required this.isoDateTimeUTC,
      @required this.localDays});

  static final _refDate = DateTime(2020);

  static Future<LogicContext> generate(
      {@required String isoCountryCode}) async {
    final now = DateTime.now().toUtc();
    final diff = now.toLocal().difference(_refDate).inDays;
    return LogicContext(
      cohort: await UserPreferences().getCohort(),
      isoCountryCode: isoCountryCode,
      isoDateTimeUTC: now.toIso8601String(),
      localDays: diff,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ctx_isoCountryCode': isoCountryCode,
      'ctx_cohort': cohort,
      'ctx_isoDateTimeUTC': isoDateTimeUTC,
      'ctx_localDays': localDays,
      // Functions
      'inExperiment': (String csvCohorts) =>
          // We can't just return (cohort < fraction), otherwise the
          // same install will always be in the experimental rollouts.
          csvCohorts.split(',').map((e) => int.parse(e)).contains(cohort),
    };
  }
}

class Logic {
  bool evaluateCondition(
      {@required String condition,
      LogicContext context,
      Map<String, dynamic> extra = const {}}) {
    if (condition == null) {
      // Most things have no display condition!
      return true;
    }
    final ctx = Map<String, dynamic>.of(context != null ? context.toMap() : {});
    ctx.addAll(extra);
    return ExpressionEvaluator().eval(Expression.parse(condition), ctx);
  }

  bool evaluateConditionWithMap(
      {@required String condition, @required Map<String, dynamic> ctx}) {
    return ExpressionEvaluator().eval(Expression.parse(condition), ctx);
  }
}

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
    final ret = Map<String, dynamic>();
    ret[m.question.id] = Map<String, bool>();
    m.question.answers.forEach((answer) {
      ret[m.question.id][answer.id] = m.selectedAnswers.contains(answer.id);
    });
    return Map.unmodifiable(ret);
  }

  Map<String, dynamic> pagesToContext(
      List<SymptomCheckerPageModel> previousPages) {
    final Map<String, dynamic> ret = {
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
