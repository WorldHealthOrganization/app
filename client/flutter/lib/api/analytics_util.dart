import 'package:html/parser.dart';

class AnalyticsUtil {
  static String cleanValue(String text) {
    String parsed = parse(text).documentElement.text;
    return parsed.length > 100 ? parsed.substring(0, 100) : parsed;
  }
}
