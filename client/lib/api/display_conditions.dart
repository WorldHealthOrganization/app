import 'package:expressions/expressions.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:who_app/api/user_preferences.dart';

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
