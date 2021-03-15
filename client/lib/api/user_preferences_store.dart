import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:who_app/api/place/place.dart';
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
    ret.obsSavedLocation = await _getSavedLocation();
    return ret;
  }

  static Future<String> _getCountryIsoCode() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.CountryISOCode.toString());
  }

  static Future<Place> _getSavedLocation() async {
    var jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.SavedLocation.toString());
    if (jsonString != null) {
      return Place.fromJsonString(jsonString);
    } else {
      return null;
    }
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

  @observable
  @protected
  Place obsSavedLocation;

  Place get savedLocation {
    return obsSavedLocation;
  }

  @action
  Future<bool> setSavedLocation(Place newValue) async {
    obsSavedLocation = newValue;
    return _setSavedLocation(newValue);
  }

  static Future<bool> _setSavedLocation(Place value) async {
    return (await SharedPreferences.getInstance()).setString(
        UserPreferenceKey.SavedLocation.toString(), value.toJsonString());
  }
}
