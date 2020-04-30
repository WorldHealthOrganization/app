import 'package:flutter/foundation.dart';

class SymptomTimeseries with ChangeNotifier {
  static final SymptomTimeseries _singleton = SymptomTimeseries._internal();

  factory SymptomTimeseries() {
    return _singleton;
  }

  void addResults() {}

  SymptomTimeseries._internal();
}
