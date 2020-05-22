import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

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

  Future<bool> getTermsOfServiceCompleted() async {
    return (await SharedPreferences.getInstance())
            .getBool(UserPreferenceKey.TermsOfServiceCompleted.toString()) ??
        false;
  }

  Future<bool> setTermsOfServiceCompleted(bool value) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.TermsOfServiceCompleted.toString(), value);
  }

  Future<bool> getAnalyticsEnabled() async {
    return (await SharedPreferences.getInstance())
            .getBool(UserPreferenceKey.AnalyticsEnabled.toString()) ??
        false;
  }

  Future<bool> setAnalyticsEnabled(bool value) async {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    if (!value) {
      await analytics.resetAnalyticsData();
    }
    await analytics.setAnalyticsCollectionEnabled(value);
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.AnalyticsEnabled.toString(), value);
  }

  Future<bool> getNotificationsEnabled() async {
    return (await SharedPreferences.getInstance())
            .getBool(UserPreferenceKey.NotificationsEnabled.toString()) ??
        false;
  }

  Future<bool> setNotificationsEnabled(bool value) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.NotificationsEnabled.toString(), value);
  }

  Future<String> getFirebaseToken() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.FirebaseToken.toString());
  }

  // Firebase
  Future<bool> setFirebaseToken(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.FirebaseToken.toString(), value);
  }

  Future<String> getClientUuid() async {
    var prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString(UserPreferenceKey.ClientUUID.toString());

    // Create if not found
    if (uuid == null) {
      uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG}).v4();
      await prefs.setString(UserPreferenceKey.ClientUUID.toString(), uuid);
    }
    return uuid;
  }

  Future<int> getCohort() async {
    final prefs = await SharedPreferences.getInstance();
    var cohort = prefs.getInt(UserPreferenceKey.ExperimentCohort.toString());

    // Create if not found
    if (cohort == null) {
      cohort = Random.secure().nextInt(100);
      await prefs.setInt(UserPreferenceKey.ExperimentCohort.toString(), cohort);
    }
    return cohort;
  }

  Future<bool> setCountryIsoCode(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.CountryISOCode.toString(), value);
  }

  Future<String> getCountryIsoCode() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.CountryISOCode.toString());
  }
}

enum UserPreferenceKey {
  OnboardingCompleted,
  TermsOfServiceCompleted,
  AnalyticsEnabled,
  NotificationsEnabled,
  ClientUUID,
  FirebaseToken,
  CountryISOCode,
  ExperimentCohort,
}
