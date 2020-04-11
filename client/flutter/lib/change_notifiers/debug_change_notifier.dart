import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';

class DebugChangeNotifier extends ChangeNotifier {
  int _extraCharacters = 0;
  int get extraCharacters => _extraCharacters;
  set extraCharacters(num value) {
    _extraCharacters = value.toInt();
    notifyListeners();
  }

  int _firstWordCharacters = 0;
  int get firstWordCharacters => _firstWordCharacters;
  set firstWordCharacters(num value) {
    _firstWordCharacters = value.toInt();
    notifyListeners();
  }

  AutoSizeGroup homeAutoSizeGroup = AutoSizeGroup();
}
