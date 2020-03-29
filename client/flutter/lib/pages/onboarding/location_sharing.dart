import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSharing extends StatefulWidget {
  @override
  _LocationSharingState createState() => _LocationSharingState();
}

class _LocationSharingState extends State<LocationSharing> {
  Map<PermissionGroup, PermissionStatus> permissions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 250.0,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: 50.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Image.asset("assets/WHO.jpg"),
            Spacer(
              flex: 1,
            ),
            PageButton(
              Color(0xff3b8bc4),
              "Allow Location Sharing",
              _allowLocationSharing,
              titleStyle: TextStyle(),
              centerVertical: true,
              centerHorizontal: true,
            ),
            FlatButton(
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: _skipLocationSharing,
            ),
          ],
        ),
      ),
    );
  }

  void _allowLocationSharing() async {
    permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.location]);
    ServiceStatus serviceStatus =
        await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    if (serviceStatus.value == 1) {
      await UserPreferences().setOnboardingCompleted(true);
    } else {
      await UserPreferences().setOnboardingCompleted(false);
    }
    _complete();
  }

  void _skipLocationSharing() async {
    await UserPreferences().setOnboardingCompleted(false);
    _complete();
  }

  void _complete() async {
    var value = await UserPreferences().getOnboardingCompleted();
    print(value.toString());
    Navigator.of(context).pop();
  }
}
