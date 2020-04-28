import 'package:flutter/cupertino.dart';

class Constants {
  static final Color backgroundColor = CupertinoColors.white; // WHITE
  static final Color primaryColor = Color(0xff0093CE); // WHO BLUE
  static final Color textColor = Color(0xff3C4245); //GREY
  static final Color primaryDark = Color(0xff1A458E); // NAVY
  static final Color accent = Color(0xffD86422); // ORANGE

  static final Color bodyTextColor = Color(0xff272626); // CHARCOAL
  static final Color emergencyRed = Color(0xffD82037);
  static final double buttonTextSpacing = -.4;
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
