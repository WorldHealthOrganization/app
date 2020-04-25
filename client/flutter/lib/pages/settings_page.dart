import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

///========================================================
/// TODO SUMMARY:
///   1. User title and subtitle texts from generated
///      file (already generated)
///=========================================================

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with WidgetsBindingObserver {
  Notifications _notifications = Notifications();

  bool _analyticsEnabled;
  bool _notificationsEnabled;
  bool _attemptEnableNotificationsOnResume = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_analyticsEnabled == null || _notificationsEnabled == null) {
      _init();
    }
  }

  _init() async {
    _analyticsEnabled = await UserPreferences().getAnalyticsEnabled();
    _notificationsEnabled = await _notifications.isEnabled();
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _toggleAnalytics(bool value) async {
    await UserPreferences().setAnalyticsEnabled(value);
    setState(() {
      _analyticsEnabled = value;
    });
  }

  _toggleNotifications(bool setEnabled) async {
    var enabled;
    if (setEnabled) {
      enabled = await _notifications.attemptEnableNotifications(
          context: context,
          showSettingsPrompt: ({showSettings}) => {
                Dialogs.showDialogToLaunchNotificationSettings(
                    context, showSettings)
              });
    } else {
      await _notifications.disableNotifications();
      enabled = false;
    }

    if (enabled == null) {
      // if enabled is null, the settings app was opened so there was no valid callback,
      // we should check the status on next resume
      _attemptEnableNotificationsOnResume = true;
    } else {
      setState(() {
        _notificationsEnabled = enabled;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _attemptEnableNotificationsOnResume) {
      _attemptEnableNotifications();
    }
  }

  void _attemptEnableNotifications() async {
    _attemptEnableNotificationsOnResume = false;
    var enabled =
        await _notifications.attemptEnableNotifications(context: context);

    if (enabled != _notificationsEnabled) {
      setState(() {
        _notificationsEnabled = enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: [
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                switchItem(
                    context: context,
                    header: S.of(context).homePagePageSliverListSettingsHeader1,
                    info: S
                        .of(context)
                        .homePagePageSliverListSettingsDataCollection,
                    isToggled: _analyticsEnabled ?? false,
                    onToggle: _toggleAnalytics),
                switchItem(
                    context: context,
                    header: S
                        .of(context)
                        .homePagePageSliverListSettingsNotificationsHeader,
                    info: S
                        .of(context)
                        .homePagePageSliverListSettingsNotificationsInfo,
                    isToggled: _notificationsEnabled ?? false,
                    onToggle: _toggleNotifications),

                /// TODO: Implement UI:-
                /// TODO:   selection of language preferences already created PR for it (#654)
              ],
            ),
          ],
        ))
      ],
      title: S.of(context).homePagePageSliverListSettings,
    );
  }

  Widget switchItem(
      {BuildContext context,
      String header,
      String info,
      bool isToggled,
      Function(bool) onToggle}) {
    return Semantics(
      toggled: isToggled,
      child: InkWell(
        onTap: () => onToggle(!isToggled),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      header,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Semantics(
                    excludeSemantics: true,
                    child: CupertinoSwitch(
                      activeColor: Constants.primaryColor,
                      value: isToggled,
                      onChanged: (newVal) => {onToggle(newVal)},
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                info,
                style: Theme.of(context).textTheme.subhead,
              )
            ],
          ),
        ),
      ),
    );
  }
}
