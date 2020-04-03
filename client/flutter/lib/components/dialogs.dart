import 'package:WHOFlutter/generated/l10n.dart';
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
}
