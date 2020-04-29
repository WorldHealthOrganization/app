import 'package:flutter/cupertino.dart';

class Constants {
  static final Color backgroundColor = CupertinoColors.white; // WHITE
  static final Color primaryColor = Color(0xff008DC9); // WHO BLUE
  static final Color textColor = Color(0xff3C4245); //GREY
  static final Color primaryDarkColor = Color(0xff1A458E); // NAVY
  static final Color accentColor = Color(0xffD86422); // ORANGE
  static final Color whoBackgroundBlueColor = Color(0xff007EB4); // WHO BLUE 2
  static final Color whoAccentYellowColor = Color(0xffFFCC00); // YELLOW

  static final Color emergencyRedColor = Color(0xffD82037);
  static final double buttonTextSpacing = -.4;

  // Typography Colors
  static final Color typographyColor = Color(0xffC4C4C4);
  static final Color bodyTextColor = Color(0xff272626); // CHARCOAL

  // Neutral Colors
  static final Color neutral1Color = Color(0xff050C1D);
  static final Color neutral2Color = Color(0xff26354E);
  static final Color neutralTextColor = Color(0xff3C4245);
  static final Color neutralTextLightColor = Color(0xff5C6164);
  static final Color neutralTextDarkColor = Color(0xff1C1E1F);
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
