import 'package:timeago/timeago.dart' as timeago;

class LastUpdate {
  final DateTime updateTime;

  LastUpdate(
    this.updateTime,
  );

  DateTime get currentTime => DateTime.now();

  Duration get differenceToNow => updateTime.difference(currentTime);

  int get hoursOld => differenceToNow.inHours.abs();

  bool get isStale => hoursOld >= staleWarningHours;

  String get timeDescription => timeago.format(updateTime);

  static int staleWarningHours = 4;
}
