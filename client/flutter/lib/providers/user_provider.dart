import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final _userPrefs = UserPreferences();

  bool _onboardingComplete;
  bool get onboardingComplete => _onboardingComplete;

  UserProvider() {
    _getOnboardingCompleted();
  }

  Future _getOnboardingCompleted() async {
    _onboardingComplete = await _userPrefs.getOnboardingCompleted();
    notifyListeners();
  }

  Future setOnboardingCompleted(bool value) async {
    _onboardingComplete = await _userPrefs.setOnboardingCompleted(value);
    notifyListeners();
  }
}
