import 'package:timeago/timeago.dart' as timeago;

class LastUpdate {
  final DateTime updateTime;

  LastUpdate(
    this.updateTime,
  );

  DateTime get currentTime => DateTime.now();

  Duration get timeDifference => updateTime.difference(currentTime);

  int get daysOld => updateTime.difference(currentTime).inDays.abs();

  int get hoursOld => updateTime.difference(currentTime).inHours.abs();

  int get weeksOld => updateTime.difference(currentTime).inDays.abs() ~/ 7;

  bool get olderThan4Hours => hoursOld >= 4;

  bool get olderThan1Day => daysOld >= 1;

  bool get olderThan1Week => weeksOld >= 1;

  String get timeDescription => timeago.format(updateTime);
}
