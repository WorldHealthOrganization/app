import 'package:flutter/material.dart';

class Constants {
  static Color backgroundColor = Color(0xffffffff);
  static Color primaryColor = Color(0xff0093CE);
  static Color textColor = Color(0xffffffff);
}

// Return a scaling factor between 0.0 and 1.0 for screens heights ranging
// from a fixed short to tall range.
double contentScale(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  const tall = 896.0;
  const short = 480.0;
  return ((height - short) / (tall - short)).clamp(0.0, 1.0);
}

bool kAnalyticsAllowed = true;
