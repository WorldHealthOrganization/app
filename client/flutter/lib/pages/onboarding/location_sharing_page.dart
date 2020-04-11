import 'package:WHOFlutter/api/who_service.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/permission_request_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

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
        final geo = Geolocator();
        // Use en_US because these are not for display, they are for indexing.
        final myPlaces = await geo.placemarkFromCoordinates(
            location.latitude, location.longitude,
            localeIdentifier: 'en_US');
        if (myPlaces.isEmpty) {
          print('No Reverse Geolocation place');
          return;
        }
        final myPlace = myPlaces.first;
        if (myPlace.isoCountryCode == null || myPlace.isoCountryCode.isEmpty) {
          print('No Reverse Geolocation country');
          // We need at least a country.
          return;
        }
        var addrComponents = [myPlace.isoCountryCode];
        [
          myPlace.administrativeArea,
          myPlace.subAdministrativeArea,
          myPlace.locality,
        ].forEach((n) {
          if (n != null && n.isNotEmpty) {
            addrComponents.insert(0, n);
          }
        });
        final addr = addrComponents.join(', ');

        final placesCityCenter =
            await geo.placemarkFromAddress(addr, localeIdentifier: 'en_US');
        if (placesCityCenter.isEmpty) {
          print('No Geolocated City Center');
          return;
        }
        final placeCityCenter = placesCityCenter.first;

        await WhoService.putLocation(
            latitude: placeCityCenter.position.latitude,
            longitude: placeCityCenter.position.longitude,
            countryCode: myPlace.isoCountryCode,
            adminArea: myPlace.administrativeArea,
            subadminArea: myPlace.subAdministrativeArea,
            locality: myPlace.locality);
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
