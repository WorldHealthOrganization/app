import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showAppDialog({
    @required BuildContext context,
    @required String title,
    String bodyText,
    Widget body,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          title: Text(title),
          content: body ?? Text(bodyText),
          actions: <Widget>[
            FlatButton(
              // TODO: Localize
              child: Text(S.of(context).commonDialogButtonOk),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showUpgradeDialogIfNeededFor(
      BuildContext context, ContentBase content) async {
    if (content.bundle.unsupportedSchemaVersionAvailable) {
      return Dialogs.showUpgradeDialog(context);
    }
  }

  static Future<void> showUpgradeDialog(BuildContext context) {
    return showAppDialog(
        context: context,
        title: S.of(context).commonContentLoadingDialogUpdateRequiredTitle,
        // TODO: Provide the sharing link here?
        bodyText:
            S.of(context).commonContentLoadingDialogUpdateRequiredBodyText);
  }

  static Future<void> showDialogToLaunchNotificationSettings(
      BuildContext context, Function requestNotificationPermissions) async {
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
              child: Text(
                  S.of(context).notificationsEnableDialogOptionOpenSettings),
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
