import 'package:who_app/api/who_service.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:s2geometry/s2geometry.dart';

import 'dart:io';

class LocationSharingPage extends StatefulWidget {
  final VoidCallback onNext;

  const LocationSharingPage({@required this.onNext}) : assert(onNext != null);

  @override
  _LocationSharingPageState createState() => _LocationSharingPageState();
}

class _LocationSharingPageState extends State<LocationSharingPage> {
  _LocationSharingPageState();

  static const MAX_S2_CELL_LEVEL = 9;

  /// True if _complete() has been invoked
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return PermissionRequestPage(
      pageTitle: S.of(context).locationSharingPageTitle,
      pageDescription: S.of(context).locationSharingPageDescription,
      backgroundImageSrc: S.of(context).locationSharingPageBackgroundImage,
      buttonTitle: S.of(context).locationSharingPageButton,
      onGrantPermission: _allowLocationSharing,
      onSkip: _skipLocationSharing,
    );
  }

  Future<void> _allowLocationSharing() async {
    try {
      if (Platform.isIOS) {
        // This does not work on Android - the later getLocation call hangs
        // forever or causes an OS-level crash.  On Android, instead,
        // we request coarse location only at the manifest permission
        // level (instead of fine).
        await Location().changeSettings(accuracy: LocationAccuracy.low);
      }
      await Location().requestPermission();

      final bool locationReady =
          await Location().hasPermission() == PermissionStatus.granted &&
              await Location().requestService();

      _complete();
      if (locationReady) {
        final location = await Location().getLocation();

        final latLng = S2LatLng.fromDegrees(location.latitude, location.longitude);

        final cellId = S2CellId.fromLatLng(latLng).parent(MAX_S2_CELL_LEVEL);

        await WhoService.putLocation(s2CellIdToken: cellId.toToken());
      }
    } catch (e) {
      _complete();
      // TODO: #876 tracks errors with analytics.
    }
  }

  void _skipLocationSharing() {
    _complete();
  }

  void _complete() {
    if (!_completed) {
      _completed = true;
      widget.onNext();
    }
  }
}
