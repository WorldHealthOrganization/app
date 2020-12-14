import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/api/user_preferences_store.dart';
import 'package:who_app/api/who_service.dart';

class Notifications {
  final WhoService service;
  final UserPreferencesStore prefs;

  Notifications({@required this.service, @required this.prefs});

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final UserPreferences _userPrefs = UserPreferences();

  Future<bool> attemptEnableNotifications(
      {BuildContext context,
      Function({@required Function showSettings}) showSettingsPrompt}) async {
    var permissionStatus =
        await NotificationPermissions.getNotificationPermissionStatus();
    var granted;
    switch (permissionStatus) {
      case PermissionStatus.unknown:
      case PermissionStatus.provisional:
        // 'unknown': iOS before permission is requested
        // 'provisional': iOS notifications that don't alert user
        // https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications
        granted =
            await requestNotificationPermissions() == PermissionStatus.granted;
        break;
      case PermissionStatus.granted:
        granted = true;
        break;
      case PermissionStatus.denied:
        if (showSettingsPrompt != null) {
          // 'denied' means the permission has been refused before or manually switched off via settings
          await showSettingsPrompt(
              showSettings: requestNotificationPermissions);
          // we're opening the settings, which is a different app, so there's no state to return
          granted = null;
        } else {
          granted = false;
        }
        break;
    }

    await setEnabled(granted == true);
    return granted;
  }

  Future setEnabled(bool granted) async {
    await _userPrefs.setNotificationsEnabled(granted);
    if (granted) _registerFCMToken();
  }

  Future<PermissionStatus> requestNotificationPermissions() =>
      NotificationPermissions.requestNotificationPermissions();

  void _registerFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    await setFirebaseToken(token);
  }

  Future disableNotifications() async {
    await setFirebaseToken(null);
    await _userPrefs.setNotificationsEnabled(false);
  }

  Future<bool> isEnabled() async =>
      await _userPrefs.getNotificationsEnabled() &&
      await NotificationPermissions.getNotificationPermissionStatus() ==
          PermissionStatus.granted;

  Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
    print('onBackgroundMessage: $message');
    return Future<void>.value();
  }

  void configure() {
    // onMessage: Fires when app is foreground
    // onLaunch: Fires when user taps and app is in background.
    // onResume: Fires when user taps and app is terminated
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: $message');
    });
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  }

  // Ask firebase for a token on every launch.
  // If the token is different from what we have stored...update it.
  void updateFirebaseToken() async {
    var notificationsEnabled = await isEnabled();

    // if notifications are disabled in OS or via user pref, ensure it's disabled on BE as well by removing token
    final tokenToSet =
        notificationsEnabled ? await _firebaseMessaging.getToken() : null;

    await setFirebaseToken(tokenToSet);
  }

  Future setFirebaseToken(String newToken) async {
    var existingToken = await _userPrefs.getFirebaseToken();
    var countryCode = await prefs.countryIsoCode;
    if (existingToken != newToken) {
      await service.putClientSettings(
          token: newToken, isoCountryCode: countryCode);
      await _userPrefs.setFirebaseToken(newToken);
    }
  }
}
