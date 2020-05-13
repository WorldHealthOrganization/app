import 'package:who_app/api/display_conditions.dart';

mixin ConditionalItem {
  String displayCondition;

  bool isDisplayed(LogicContext ctx) {
    return Logic().evaluateCondition(condition: displayCondition, context: ctx);
  }
}
