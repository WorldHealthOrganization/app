import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SymptomTimeseries with ChangeNotifier {
  static final SymptomTimeseries _singleton = SymptomTimeseries._internal();

  final _storage = FlutterSecureStorage();

  factory SymptomTimeseries() {
    return _singleton;
  }

  void addResult(SymptomResult r) async {
    await _storage.write(
        key: r.timestamp.toUtc().toIso8601String(), value: r.risk.toString());
    notifyListeners();
  }

  void clearAll() async {
    await _storage.deleteAll();
    notifyListeners();
  }

  Future<List<SymptomResult>> results() async {
    final vals = await _storage.readAll();
    final r = vals.keys.toList();
    r.sort();
    return r
        .map((k) => SymptomResult(
            timestamp: DateTime.parse(k).toUtc(), risk: int.parse(vals[k])))
        .toList(growable: false);
  }

  SymptomTimeseries._internal();
}

class SymptomResult {
  final int risk;
  final DateTime timestamp;

  SymptomResult({@required this.risk, @required this.timestamp});
}
