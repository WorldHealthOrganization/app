import 'package:intl/intl.dart';

extension WHOFormat on DateTime {
  String get whoFormat => DateFormat.yMMMd().format(
        // Timstamps are for midnight. It looks as though the WHO dashboard uses the date of when the data was reported to WHO rather than the original day.
        add(
          Duration(
            days: 1,
          ),
        ),
      );
}
