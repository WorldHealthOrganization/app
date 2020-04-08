import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/api/who_service.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:pedantic/pedantic.dart';

class Notifications {
  static final Notifications _singleton = Notifications._internal();

  factory Notifications() => _singleton;

  Notifications._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserPreferences _userPrefs = UserPreferences();

  Future<bool> attemptEnableNotifications({BuildContext context, bool launchSettingsIfDenied = true}) async {
    var permissionStatus = await NotificationPermissions.getNotificationPermissionStatus();
    var granted;
    switch (permissionStatus) {
      case PermissionStatus.unknown:
        // if a status is 'unknown' it means we're on iOS and we haven't requested the permission before
        granted = await requestNotificationPermissions() == PermissionStatus.granted;
        break;
      case PermissionStatus.granted:
        granted = true;
        break;
      case PermissionStatus.denied:
        if (launchSettingsIfDenied == true) {
          // 'denied' means the permission has been refused before or manually switched off via settings
          unawaited(showDialogToLaunchSettings(context));
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

  Future<PermissionStatus> requestNotificationPermissions() => NotificationPermissions.requestNotificationPermissions();

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
      await NotificationPermissions.getNotificationPermissionStatus() == PermissionStatus.granted;

  void configure() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }

  // Ask firebase for a token on every launch.
  // If the token is different from what we have stored...update it.
  void updateFirebaseToken() async {
    var notificationsEnabled = await _userPrefs.getNotificationsEnabled();

    if (notificationsEnabled) {
      final token = await _firebaseMessaging.getToken();
      final storedToken = await _userPrefs.getFirebaseToken();
      if (token != storedToken) {
        await setFirebaseToken(token);
      }
    }
  }

  Future setFirebaseToken(String newToken) async {
    var exitsingToken = await _userPrefs.getFirebaseToken();
    if (exitsingToken != newToken) {
      await WhoService.putDeviceToken(newToken);
      await _userPrefs.setFirebaseToken(newToken);
    }
  }

  /// UI behaviour, perhaps should be extracted to a separate class

  Future showDialogToLaunchSettings(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).notificationsEnableDialogHeader),
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text(S.of(context).notificationsEnableDialogText)],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(S.of(context).notificationsEnableDialogOptionLater),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(S.of(context).notificationsEnableDialogOptionOpenSettings),
              onPressed: () {
                requestNotificationPermissions();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
