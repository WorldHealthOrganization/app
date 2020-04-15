import 'package:WHOFlutter/api/who_service.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:s2geometry/s2geometry.dart';

class LocationSharingPage extends StatefulWidget {
  final VoidCallback onNext;

  const LocationSharingPage({@required this.onNext}) : assert(onNext != null);

  @override
  _LocationSharingPageState createState() => _LocationSharingPageState();
}

class _LocationSharingPageState extends State<LocationSharingPage> {
  _LocationSharingPageState();

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
      await Location().requestPermission();
      final bool locationReady =
          await Location().hasPermission() == PermissionStatus.granted &&
              await Location().requestService();

      _complete();
      if (locationReady) {
        LocationData location = await Location().getLocation();

        S2LatLng latLng = new S2LatLng.fromDegrees(location.latitude, location.longitude);
        S2CellId cellId = new S2CellId.fromLatLng(latLng);

        await WhoService.putLocation(s2CellId: cellId.id());
      }
    } catch (_) {
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
