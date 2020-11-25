import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:who_app/main.dart';

// TODO: Delete this class.  The use of this class directly by new UI code is discouraged.
// Instead, rely on a Provider-supplied UserPreferencesStore and manipulate the properties therein.
// To avoid inconsistencies, a user preference must be implemented either in this class
// or UserPreferencesStore, but not both.
class UserPreferences {
  static final UserPreferences _singleton = UserPreferences._internal();

  factory UserPreferences() {
    return _singleton;
  }

  UserPreferences._internal();

  Future<String> getLastRunVersion() async {
    return (await SharedPreferences.getInstance())
            .getString(UserPreferenceKey.LastRunVersion.toString()) ??
        false;
  }

  Future<bool> setLastRunVersion() async {
    return (await SharedPreferences.getInstance()).setString(
        UserPreferenceKey.LastRunVersion.toString(),
        '${packageInfo.version}+${packageInfo.buildNumber}');
  }

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

  /// Was the user shown the introductory pages as part of onboarding, using updated key for V1 launch
  Future<bool> getOnboardingCompletedV1() async {
    return (await SharedPreferences.getInstance())
            .getBool(UserPreferenceKey.OnboardingCompletedV1.toString()) ??
        false;
  }

  /// Was the user shown the introductory pages as part of onboarding, using updated key for V1 launch
  Future<bool> setOnboardingCompletedV1(bool value) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.OnboardingCompletedV1.toString(), value);
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
    var analytics = FirebaseAnalytics();
    if (!value) {
      await analytics.resetAnalyticsData();
    }
    await analytics.setAnalyticsCollectionEnabled(value);
    var result = (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.AnalyticsEnabled.toString(), value);
    await _updateFirebaseAutoInit();
    return result;
  }

  Future<bool> getNotificationsEnabled() async {
    return (await SharedPreferences.getInstance())
            .getBool(UserPreferenceKey.NotificationsEnabled.toString()) ??
        false;
  }

  Future<bool> setNotificationsEnabled(bool value) async {
    var result = (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.NotificationsEnabled.toString(), value);
    await _updateFirebaseAutoInit();
    return result;
  }

  Future<void> _updateFirebaseAutoInit() async {
    // Updates the firebase auto init option. This method is called
    // after a user modifies either analytics or notifications.

    // Enable Firebase Auto Init iff either notifications or analytics is enabled
    var firebase_auto_init =
        (await getNotificationsEnabled()) || (await getAnalyticsEnabled());
    await FirebaseMessaging.instance.setAutoInitEnabled(firebase_auto_init);
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

  Future<int> getLastUpdatedContent() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdatedContent =
        prefs.getInt(UserPreferenceKey.LastUpdatedContent.toString());
    // returns null if content has never been updated before
    return lastUpdatedContent;
  }

  Future<bool> setLastUpdatedContent(int milliSeconds) async {
    final prefs = await SharedPreferences.getInstance();
    final update = await prefs.setInt(
        UserPreferenceKey.LastUpdatedContent.toString(), milliSeconds);

    return update;
  }
}

enum UserPreferenceKey {
  OnboardingCompleted,
  OnboardingCompletedV1,
  TermsOfServiceCompleted,
  AnalyticsEnabled,
  NotificationsEnabled,
  ClientUUID,
  FirebaseToken,
  CountryISOCode,
  ExperimentCohort,
  LastRunVersion,
  LastUpdatedContent
}
