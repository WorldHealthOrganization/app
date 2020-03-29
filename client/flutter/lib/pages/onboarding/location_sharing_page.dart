import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';

class LocationSharingPage extends StatefulWidget {
  @override
  _LocationSharingPageState createState() => _LocationSharingPageState();
}

class _LocationSharingPageState extends State<LocationSharingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: PermissionRequestPage(
            buttonTitle: S.of(context).onBoardingLocationSharingPageButtonAllow,
            onGrantPermission: _allowLocationSharing,
            onSkip: _skipLocationSharing,
          ),
        ),
      ),
    );
  }

  void _allowLocationSharing() async {
    _complete();
  }

  void _skipLocationSharing() async {
    _complete();
  }

  void _complete() async {
    Navigator.of(context).pop();
  }
}

