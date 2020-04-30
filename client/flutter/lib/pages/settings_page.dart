import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/pages/main_pages/routes.dart';

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
      disableBackButton: true,
      color: Constants.greyBackgroundColor,
      heroTag: HeroTags.settings,
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
                SizedBox(
                  height: 20,
                ),
                menu(context),
                Container(
                  height: 24,
                ),

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

  Widget menu(BuildContext context) {
    final divider = Container(height: 1, color: Color(0xffC9CDD6));
    final Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      divider,
      menuItem(
        title: S.of(context).homePagePageSliverListShareTheApp,
        onTap: () {
          FirebaseAnalytics().logShare(
              contentType: 'App', itemId: null, method: 'Website link');
          Share.share(
            S.of(context).commonWhoAppShareIconButtonDescription,
            sharePositionOrigin:
                Rect.fromLTWH(0, 0, size.width, size.height / 2),
          );
        },
      ),
      divider,
      // TODO: Localize
      menuItem(
          title: 'Provide app feedback',
          onTap: () {
            FirebaseAnalytics().logEvent(name: 'Feedback');
            // TODO: Implement feedback #989 #1015
          }),
      divider,
      menuItem(
        title: S.of(context).homePagePageSliverListAboutTheApp,
        onTap: () {
          return Navigator.of(context, rootNavigator: true).pushNamed('/about');
        },
      ),
      divider,
    ]);
  }

  Widget menuItem({BuildContext context, String title, Function() onTap}) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        title: ThemedText(
          title,
          variant: TypographyVariant.button,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFC9CDD6),
        ),
        onTap: onTap,
      ),
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
      child: Material(
        color: Constants.greyBackgroundColor,
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
                      child: ThemedText(header,
                          variant: TypographyVariant.h3,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Constants.neutral1Color,
                          )),
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
                ThemedText(
                  info,
                  variant: TypographyVariant.body,
                  style: TextStyle(
                    color: Constants.neutral2Color,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
