import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Place {
  final double latitude;
  final double longitude;
  final String description;

  /// Google Places identifier.
  final String id;

  Place(
      {@required this.latitude,
      @required this.longitude,
      @required this.description,
      @required this.id});

  factory Place.fromJsonString(String jsonString) {
    var propertyMap = json.decode(jsonString);
    var latitude = propertyMap['latitude'];
    var longitude = propertyMap['longitude'];
    var description = propertyMap['description'];
    var id = propertyMap['id'];
    return Place(
        latitude: latitude,
        longitude: longitude,
        description: description,
        id: id);
  }

  String toJsonString() {
    var propertyMap = {
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'id': id
    };
    return json.encode(propertyMap);
  }
}
