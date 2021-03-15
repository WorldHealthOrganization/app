import 'package:flutter/foundation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:who_app/api/place/place_prediction.dart';

class PlaceService {
  static final String _apiKey = '';
  final String _countryIsoCode;
  final GoogleMapsPlaces _places;

  factory PlaceService({@required String countryIsoCode}) {
    var places = GoogleMapsPlaces(apiKey: _apiKey);
    return PlaceService._internal(countryIsoCode, places);
  }

  PlaceService._internal(this._countryIsoCode, this._places);

  Future<List<PlacePrediction>> getAutocompleteSuggestions(
      {@required String partialAddress, @required String sessionToken}) async {
    var response = await _places.autocomplete(partialAddress,
        components: [Component(Component.country, _countryIsoCode)],
        types: ['(regions)']);
    print(response.status);
    if (response.status != GoogleResponseStatus.okay) {
      print(response.errorMessage);
      return [];
    }
    return response.predictions
        .map((prediction) =>
            PlacePrediction(prediction.description, prediction.placeId))
        .toList();
  }
}
