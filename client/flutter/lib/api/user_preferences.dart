import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _singleton = UserPreferences._internal();

  factory UserPreferences() {
    return _singleton;
  }

  UserPreferences._internal();

  /// Was the user shown the introductory pages as part of onboarding
  Future<bool> getOnboardingCompleted() async {
    return (await SharedPreferences.getInstance())
            .getBool(UserPreferenceKey.OnboardingCompleted.toString()) ??
        false;
  }

  /// Was the user shown the introductory pages as part of onboarding
  Future<bool> setOnboardingCompleted(bool value) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.OnboardingCompleted.toString(), value);
  }
}

enum UserPreferenceKey {
  OnboardingCompleted,
}
