import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:who_app/api/user_preferences.dart';

// Whenever this file is modified, regenerate the .g.dart file using the command:
// flutter packages pub run build_runner build
part 'user_preferences_store.g.dart';

class UserPreferencesStore extends _UserPreferencesStore
    with _$UserPreferencesStore {
  UserPreferencesStore.empty();

  static Future<UserPreferencesStore> readFromSharedPreferences() async {
    final ret = UserPreferencesStore.empty();
    ret.obsCountryIsoCode = await _getCountryIsoCode();
    return ret;
  }

  static Future<String> _getCountryIsoCode() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.CountryISOCode.toString());
  }
}

abstract class _UserPreferencesStore with Store {
  _UserPreferencesStore();

  @observable
  @protected
  String obsCountryIsoCode;

  String get countryIsoCode {
    return obsCountryIsoCode;
  }

  @action
  Future<bool> setCountryIsoCode(String newValue) async {
    obsCountryIsoCode = newValue;
    return _setPrefCountryIsoCode(newValue);
  }

  static Future<bool> _setPrefCountryIsoCode(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.CountryISOCode.toString(), value);
  }
}
