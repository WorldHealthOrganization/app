import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class NotificationsPage extends StatefulWidget {
  final VoidCallback onNext;

  const NotificationsPage({@required this.onNext}) : assert(onNext != null);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Notifications _notifications = Notifications();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CupertinoColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 36.0, bottom: 18.0),
              child: SvgPicture.asset(
                  'assets/svg/undraw-onboarding-notifications.svg'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 36.0, right: 20.0, bottom: 18.0),
                child: ThemedText(
                  S.of(context).notificationsPagePermissionRequestPageTitle,
                  variant: TypographyVariant.h2,
                  style: TextStyle(
                    color: Constants.accentNavyColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 36.0, right: 54.0, bottom: 42.0),
                child: ThemedText(
                  S
                      .of(context)
                      .notificationsPagePermissionRequestPageDescription,
                  variant: TypographyVariant.body,
                  style: TextStyle(
                    color: Constants.neutral1Color,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 112.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Button(
                      onPressed: () async {
                        await _allowNotifications();
                      },
                      color: Constants.whoBackgroundBlueColor,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 12.0,
                        ),
                        child: ThemedText(
                          S
                              .of(context)
                              .notificationsPagePermissionRequestPageButton,
                          variant: TypographyVariant.button,
                          style: TextStyle(
                            color: CupertinoColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () async {
                        await _skipNotifications();
                      },
                      child: ThemedText(
                        S.of(context).commonPermissionRequestPageButtonSkip,
                        variant: TypographyVariant.button,
                        style: TextStyle(
                          color:
                              Constants.neutralTextLightColor.withOpacity(0.5),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _allowNotifications() async {
    await _notifications.attemptEnableNotifications(context: context);
    _complete();
  }

  void _skipNotifications() async {
    await _notifications.disableNotifications();
    _complete();
  }

  void _complete() {
    widget.onNext();
  }
}
