import 'dart:math';

class JitterLocation {
  double rad_Earth  = 6378.16;
  JitterLocation();

double randomInRange(from, to) {
  return double.parse((Random.secure().nextDouble() * (to - from) + from).toStringAsFixed(10)) * 1;
}

Map jitter(lat, lng, kms) {
  double one_degree = (2 * pi * rad_Earth) / 360;
  double one_km  = 1 / one_degree;
  return {
    'lat': randomInRange(
      lat - (kms * one_km),
      lat + (kms * one_km),
    ),
    'lng': randomInRange(
      lng - (kms * one_km),
      lng + (kms * one_km),
    )
  };
}
}