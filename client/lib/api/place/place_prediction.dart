/// An address autocomplete prediction result.
class PlacePrediction {
  final String displayText;

  /// The Google Places identifier for the prediction.
  final String placeID;

  PlacePrediction(this.displayText, this.placeID);
}
