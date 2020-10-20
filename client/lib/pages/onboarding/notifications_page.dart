import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/notifications.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class NotificationsPage extends StatelessWidget {
  final VoidCallback onNext;

  const NotificationsPage({@required this.onNext}) : assert(onNext != null);

  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<Notifications>(context);
    return Material(
      color: CupertinoColors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        left: 36.0,
                        bottom: 18.0,
                        top: 10,
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/undraw-onboarding-notifications.svg',
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 36.0,
                            right: 20.0,
                            bottom: 18.0,
                          ),
                          child: ThemedText(
                            S
                                .of(context)
                                .notificationsPagePermissionRequestPageTitle,
                            variant: TypographyVariant.h2,
                            style: TextStyle(
                              color: Constants.accentNavyColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 36.0, right: 54.0, bottom: 12.0),
                          child: ThemedText(
                            S
                                .of(context)
                                .notificationsPagePermissionRequestPageDescription,
                            variant: TypographyVariant.body,
                            style: TextStyle(
                              color: Constants.neutral1Color,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Button(
                    onPressed: () async {
                      await notifications.attemptEnableNotifications(
                          context: context);
                      onNext();
                    },
                    backgroundColor: Constants.whoBackgroundBlueColor,
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
                      await notifications.disableNotifications();
                      onNext();
                    },
                    child: ThemedText(
                      S.of(context).commonPermissionRequestPageButtonSkip,
                      variant: TypographyVariant.button,
                      style: TextStyle(
                        color: Constants.neutralTextLightColor.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
