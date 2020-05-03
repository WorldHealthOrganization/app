import 'package:flutter/cupertino.dart';

class AppTheme {
  final BuildContext context;
  AppTheme(this.context);
  Color get backgroundColor =>
      isLight(context) ? CupertinoColors.white : CupertinoColors.black;

  Color get greyBackgroundColor => Color(0xFFF9F8F7); // GREY
  Color get primaryColor => Color(0xff008DC9); // WHO BLUE
  Color get textColor => Color(0xff3C4245); //GREY
  Color get darkModeTextColor =>
      CupertinoColors.systemGrey4; //TODO: GET ACTUAL COLOR
  Color get primaryDarkColor => Color(0xff1A458E); // NAVY
  Color get accentColor => Color(0xffD86422); // ORANGE
  Color get whoBackgroundBlueColor => Color(0xff007EB4); // WHO BLUE 2
  Color get whoAccentYellowColor => Color(0xffFFCC00); // YELLOW
  Color get bodyTextColor => Color(0xff272626); // CHARCOAL

  Color get emergencyRedColor => Color(0xffD82037);
  double get buttonTextSpacing => -.4;
  Color get menuButtonColor => Color(0xCC1694BE);

  // Neutral Colors
  Color get neutral1Color => Color(0xff050C1D);
  Color get neutral2Color => Color(0xff26354E);
  Color get neutralTextColor => Color(0xff3C4245);
  Color get neutralTextLightColor => Color(0xff5C6164);
  Color get neutralTextDarkColor => Color(0xff1C1E1F);

  // Illustration Colors
  Color get illustrationBlue1Color => Color(0xffD5F5FD);
}

// Return a scaling factor between 0.0 and 1.0 for screens heights ranging
// from a fixed short to tall range.
double contentScale(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  const tall = 896.0;
  const short = 480.0;
  return ((height - short) / (tall - short)).clamp(0.0, 1.0);
}

bool isLight(BuildContext context) {
  return CupertinoTheme.brightnessOf(context) == Brightness.light;
}

// Return a value between low and high for screens heights ranging
// from a fixed short to tall range.
double contentScaleFrom(BuildContext context, double low, double high) {
  return low + contentScale(context) * (high - low);
}
