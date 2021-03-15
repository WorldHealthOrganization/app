import 'package:flutter/cupertino.dart';
import 'package:who_app/api/place/place.dart';
import 'package:who_app/api/user_preferences_store.dart';

/// Manages storage and retrieval of a user's proximate location.
class LocationProvider {
  final UserPreferencesStore prefs;

  LocationProvider({@required this.prefs});

  /// Returns the last saved user location (if any).
  Place getLocation() {
    return prefs.savedLocation;
  }

  /// Saves the provided location to local storage only.
  void saveLocationLocal(Place place) {
    prefs.setSavedLocation(place);
  }
}
