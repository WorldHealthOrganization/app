import 'package:intl/intl.dart';

extension WHOFormat on DateTime {
  String get whoFormat => DateFormat.yMMMd().format(
        // Timestamps are for midnight so the day it applies to is ambiguous.
        // Sets date to UTC to match the WHO Dashboard: http://covid19.who.int
        toUtc()
      );
}
