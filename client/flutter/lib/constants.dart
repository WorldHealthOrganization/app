import 'package:flutter/cupertino.dart';

class Constants {
  // Primary color palette
  static const Color primaryColor = Color(0xff008DC9); // WHO BLUE
  static const Color primaryDarkColor = Color(0xff2364AA); // NEW BLUE
  static const Color accentColor = Color(0xffD86422); // ORANGE
  static const Color whoAccentYellowColor = Color(0xffFFCC00); // YELLOW
  static const Color accentTealColor = Color(0xff44BBA4); // TEAL
  static const Color accentNavyColor = Color(0xff1A458E); // NAVY

  // Background colors
  static const Color backgroundColor = CupertinoColors.white; // WHITE
  static const Color greyBackgroundColor = Color(0xFFF9F8F7); // GREY
  static const Color whoBackgroundBlueColor = Color(0xff007EB4); // WHO BLUE 2
  static const Color homeHeaderGreenColor = Color(0xffFAE8A9);

  // Element colors
  static const Color bodyTextColor = Color(0xff272626); // CHARCOAL
  static const Color textColor = Color(0xff3C4245); // GREY
  static const Color emergencyRedColor = Color(0xffD82037);
  static const Color menuButtonColor = Color(0xCC1694BE);
  static const Color successCheckColor = Color(0xff9BC53D); // NEW GREEN
  static const Color itemBorderColor = Color.fromARGB(64, 92, 97, 100);

  // Neutral Colors
  static const Color neutral1Color = Color(0xff050C1D);
  static const Color neutral2Color = Color(0xff26354E);
  static const Color neutral3Color = Color(0xffC9CDD6); // LIGHT GREY
  static const Color neutralTextColor = Color(0xff3C4245);
  static const Color neutralTextLightColor = Color(0xff5C6164);
  static const Color neutralTextDarkColor = Color(0xff1C1E1F);

  // Illustration Colors
  static const Color illustrationBlue1Color = Color(0xffD5F5FD);
  static const Color illustrationPinkColor = Color(0xffEC96AA); // PINK

  // Spacing
  static const double buttonTextSpacing = -.4;
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
