import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class Constants {
  static const Color backgroundColor = Color(0xffffffff);
  static const Color primaryColor = Color(0xff0093CE);
  static const Color textColor = Color(0xffffffff);
}

// Return a scaling factor between 1.0 and 2.0 for screens heights ranging
// over a fixed short and tall range.
double contentScale(BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  const double tall = 812.0;
  const double short = 480.0;
  return ((height - short) / (tall - short)).clamp(1.0, 2.0);
}
