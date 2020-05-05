import 'package:flutter/cupertino.dart';

class AppTheme extends AppThemeData{
  factory AppTheme(BuildContext context){
    return isLight(context)?LightTheme():DarkTheme();

  }
  
}

class LightTheme extends AppThemeData {
  factory() => AppThemeData(
        backgroundColor: CupertinoColors.white,
        greyBackgroundColor: Color(0xFFF9F8F7), // GREY
        primaryColor: Color(0xff008DC9), // WHO BLUE
        textColor: Color(0xff3C4245), //GREY
        darkModeTextColor: CupertinoColors.systemGrey4, //TODO: ACTUAL COLOR
        primaryDarkColor: Color(0xff1A458E), // NAVY
        accentColor: Color(0xffD86422), // ORANGE
        whoBackgroundBlueColor: Color(0xff007EB4), // WHO BLUE 2
        whoAccentYellowColor: Color(0xffFFCC00), // YELLOW
        bodyTextColor: Color(0xff272626), // CHARCOAL

        emergencyRedColor: Color(0xffD82037),
        menuButtonColor: Color(0xCC1694BE),

        // Neutral Colors

        neutral1Color: Color(0xff050C1D),
        neutral2Color: Color(0xff26354E),
        neutralTextColor: Color(0xff3C4245),
        neutralTextLightColor: Color(0xff5C6164),
        neutralTextDarkColor: Color(0xff1C1E1F),

        // Illustration Colors

        illustrationBlue1Color: Color(0xffD5F5FD),
      );
}


class DarkTheme extends AppThemeData {
  factory() => AppThemeData(
        backgroundColor: CupertinoColors.white,
        greyBackgroundColor: Color(0xFFF9F8F7), // GREY
        primaryColor: Color(0xff008DC9), // WHO BLUE
        textColor: Color(0xff3C4245), //GREY
        darkModeTextColor: CupertinoColors.systemGrey4, //TODO: ACTUAL COLOR
        primaryDarkColor: Color(0xff1A458E), // NAVY
        accentColor: Color(0xffD86422), // ORANGE
        whoBackgroundBlueColor: Color(0xff007EB4), // WHO BLUE 2
        whoAccentYellowColor: Color(0xffFFCC00), // YELLOW
        bodyTextColor: Color(0xff272626), // CHARCOAL

        emergencyRedColor: Color(0xffD82037),
        menuButtonColor: Color(0xCC1694BE),

        // Neutral Colors

        neutral1Color: Color(0xff050C1D),
        neutral2Color: Color(0xff26354E),
        neutralTextColor: Color(0xff3C4245),
        neutralTextLightColor: Color(0xff5C6164),
        neutralTextDarkColor: Color(0xff1C1E1F),

        // Illustration Colors

        illustrationBlue1Color: Color(0xffD5F5FD),
      );
}

class AppThemeData {
  AppThemeData({
    @required this.backgroundColor,
    @required this.greyBackgroundColor,
    @required this.primaryColor,
    @required this.textColor,
    @required this.darkModeTextColor,
    @required this.primaryDarkColor,
    @required this.accentColor,
    @required this.whoBackgroundBlueColor,
    @required this.whoAccentYellowColor,
    @required this.bodyTextColor,
    @required this.emergencyRedColor,
    @required this.menuButtonColor,
    @required this.neutral1Color,
    @required this.neutral2Color,
    @required this.neutralTextColor,
    @required this.neutralTextLightColor,
    @required this.neutralTextDarkColor,
    @required this.illustrationBlue1Color,
  });
  final Color backgroundColor;

  final Color greyBackgroundColor;
  final Color primaryColor;
  final Color textColor;
  final Color darkModeTextColor;
  final Color primaryDarkColor;
  final Color accentColor;
  final Color whoBackgroundBlueColor;
  final Color whoAccentYellowColor;
  final Color bodyTextColor;

  final Color emergencyRedColor;
  final double buttonTextSpacing = -.4;
  final Color menuButtonColor;

  // Neutral Colors
  final Color neutral1Color;
  final Color neutral2Color;
  final Color neutralTextColor;
  final Color neutralTextLightColor;
  final Color neutralTextDarkColor;

  // Illustration Colors
  final Color illustrationBlue1Color;
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

/*

 */
