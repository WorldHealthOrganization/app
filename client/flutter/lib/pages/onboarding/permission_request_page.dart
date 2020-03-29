import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class PermissionRequestPage extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onGrantPermission;
  final VoidCallback onSkip;

  const PermissionRequestPage({
    Key key,
    @required this.buttonTitle,
    @required this.onGrantPermission,
    @required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Image.asset("assets/WHO.jpg"),
        Spacer(),
        PageButton(
          Color(0xff3b8bc4),
          buttonTitle,
          onGrantPermission,
          titleStyle: TextStyle(),
          centerVertical: true,
          centerHorizontal: true,
        ),
        SizedBox(height: 16),
        FlatButton(
          child: Text(
            S.of(context).onBoardingLocationSharingPageButtonSkip,
            style: TextStyle(color: Colors.grey),
          ),
          onPressed: onSkip,
        ),
        Spacer(),
      ],
    );
  }
}
