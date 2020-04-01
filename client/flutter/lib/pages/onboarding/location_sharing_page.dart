import 'package:WHOFlutter/api/jitter_location.dart';
import 'package:WHOFlutter/api/who_service.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationSharingPage extends StatefulWidget {
  final VoidCallback onNext;

  const LocationSharingPage({@required this.onNext}) : assert(onNext != null);

  @override
  _LocationSharingPageState createState() => _LocationSharingPageState();
}

class _LocationSharingPageState extends State<LocationSharingPage> {
  _LocationSharingPageState();

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
      if (await Location().hasPermission() == PermissionStatus.granted) {
        LocationData location = await Location().getLocation();
        Map jitteredLocationData = JitterLocation().jitter(location.latitude, location.longitude, 5/*kms refers to kilometers*/);
        
        await WhoService.putLocation(
          latitude: jitteredLocationData['lat'],
          longitude: jitteredLocationData['lng']);
      }
    } catch(_) {
      // ignore for now.
    } finally {
      _complete();
    }
  }

  void _skipLocationSharing() {
    _complete();
  }

  void _complete() {
    widget.onNext();
  }
}
