import 'package:intl/intl.dart';

extension WHOFormat on DateTime {
  String get whoFormat => DateFormat.yMMMd().format(
        // Timestamps are for midnight so the day it applies to is ambiguous.
        // Add 1 day to match the WHO Dashboard: http://covid19.who.int
        add(
          Duration(
            days: 1,
          ),
        ),
      );
}
