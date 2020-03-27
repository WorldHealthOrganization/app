import 'package:flutter/material.dart';

class Constants {
  static Color backgroundColor = Color(0xffffffff);
  static Color primaryColor = Color(0xff0093CE);
  static Color textColor = Color(0xffffffff);
}

// Return a scaling factor between 1.0 and 2.0 for screens heights ranging
// over a fixed short and tall range.
double contentScale(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  const tall = 812.0;
  const short = 480.0;
  return ((height - short) / (tall - short)).clamp(1.0, 2.0);
}
