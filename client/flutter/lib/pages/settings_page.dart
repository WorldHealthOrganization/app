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
    Color backgroundColor = isLight(context)
        ? CupertinoColors.white
        : CupertinoColors.darkBackgroundGray;
    Color textColor = isLight(context) ? null : AppTheme(context).darkModeTextColor;

    Container divider(BuildContext context) => Container(
        height: 1,
        color:
            isLight(context) ? Color(0xffC9CDD6) : CupertinoColors.systemGrey);
    final Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      divider(context),
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
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
      divider(context),
      // TODO: Localize
      menuItem(
        title: 'Provide app feedback',
        onTap: () {
          FirebaseAnalytics().logEvent(name: 'Feedback');
          // TODO: Implement feedback #989 #1015
        },
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
      divider(context),
      menuItem(
        title: S.of(context).homePagePageSliverListAboutTheApp,
        onTap: () {
          return Navigator.of(context, rootNavigator: true).pushNamed('/about');
        },
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
      divider(context),
    ]);
  }

  Widget menuItem(
      {BuildContext context,
      String title,
      Function() onTap,
      Color backgroundColor,
      Color textColor}) {
    return Material(
      color: backgroundColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        title: ThemedText(
          title,
          variant: TypographyVariant.button,
          style: TextStyle(color: textColor),
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
        type: MaterialType.transparency,
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
                            color: isLight(context)
                                ? AppTheme(context).neutral1Color
                                : AppTheme(context).darkModeTextColor,
                          )),
                    ),
                    Semantics(
                      excludeSemantics: true,
                      child: CupertinoSwitch(
                        activeColor: AppTheme(context).primaryColor,
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
                    color: isLight(context)
                        ? AppTheme(context).neutral2Color
                        : AppTheme(context).darkModeTextColor,
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
