import 'package:flutter/material.dart';

class Constants {
  static Color backgroundColor = Colors.white;
  static Color primaryColor = Color(0xff0093CE); // WHO BLUE
  static Color textColor = Color(0xff3C4245);
  static Color primaryDark = Color(0xff1A458E); // NAVY
  static double buttonTextSpacing = -.4;
}

// Return a scaling factor between 0.0 and 1.0 for screens heights ranging
// from a fixed short to tall range.
double contentScale(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  const tall = 896.0;
  const short = 480.0;
  return ((height - short) / (tall - short)).clamp(0.0, 1.0);
}

// Return a value between low and high for screens heights ranging
// from a fixed short to tall range.
double contentScaleFrom(BuildContext context, double low, double high) {
  return low + contentScale(context) * (high - low);
}
