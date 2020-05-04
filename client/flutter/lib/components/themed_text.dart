import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/constants.dart';

enum TypographyVariant {
  title,
  header,
  h1,
  h2,
  h3,
  h4,
  body,
  button,
  bodySmall
}

class ThemedText extends StatelessWidget {
  final String data;
  final TypographyVariant variant;

  final Locale locale;
  final int maxLines;
  final TextOverflow overflow;
  final String semanticsLabel;
  final bool softWrap;
  final StrutStyle strutStyle;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final double textScaleFactor;
  final TextWidthBasis textWidthBasis;

  ThemedText(
    this.data, {
    @required this.variant,
    Key key,
    this.locale,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    this.softWrap,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.textWidthBasis,
  }) : super(key: key);

  static TextStyle styleForVariant(TypographyVariant variant) {
    switch (variant) {
      case TypographyVariant.title:
        return TextStyle(
          color: Constants.primaryDarkColor,
          fontWeight: FontWeight.w900,
          fontSize: 48,
          height: 1.0,
        );
        break;
      case TypographyVariant.header:
        return TextStyle(
          color: Constants.primaryDarkColor,
          fontWeight: FontWeight.w800,
          fontSize: 34,
          height: 0.88,
          letterSpacing: -0.5,
        );
        break;
      case TypographyVariant.h1:
        return TextStyle(
          color: Constants.primaryDarkColor,
          fontWeight: FontWeight.w900,
          fontSize: 40,
          height: 1.0,
        );
        break;
      case TypographyVariant.h2:
        return TextStyle(
          color: Constants.primaryDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          height: 1.2,
          letterSpacing: -0.0011,
        );
        break;
      case TypographyVariant.h3:
        return TextStyle(
          color: Constants.neutralTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          height: 1.167,
        );
        break;
      case TypographyVariant.h4:
        return TextStyle(
          color: Constants.neutralTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          height: 1.333,
          letterSpacing: 0.18,
        );
        break;
      case TypographyVariant.body:
        return TextStyle(
          color: Constants.bodyTextColor,
          fontWeight: FontWeight.normal,
          fontSize: 16,
          height: 1.375,
          letterSpacing: -0.32,
        );
        break;
      case TypographyVariant.button:
        return TextStyle(
          color: Constants.neutral2Color,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.222,
        );
        break;
      case TypographyVariant.bodySmall:
        return TextStyle(
          color: Constants.neutral2Color,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1.43,
        );
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        ThemedText.styleForVariant(this.variant).merge(this.style);
    return Text(
      this.data,
      locale: this.locale,
      maxLines: this.maxLines,
      overflow: this.overflow,
      semanticsLabel: this.semanticsLabel,
      softWrap: this.softWrap,
      strutStyle: this.strutStyle,
      style: style,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      textScaleFactor: this.textScaleFactor,
      textWidthBasis: this.textWidthBasis,
    );
  }
}

class AutoSizeThemedText extends StatelessWidget {
  final String data;
  final TypographyVariant variant;

  final AutoSizeGroup group;
  final Locale locale;

  final double maxFontSize;
  final int maxLines;
  final double minFontSize;
  final TextOverflow overflow;
  final Widget overflowReplacement;
  final List<double> presetFontSizes;
  final String semanticsLabel;
  final bool softWrap;
  final double stepGranularity;
  final StrutStyle strutStyle;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Key textKey;
  final double textScaleFactor;
  final bool wrapWords;

  AutoSizeThemedText(
    this.data, {
    @required this.variant,
    Key key,
    this.group,
    this.locale,
    this.maxFontSize = double.infinity,
    this.maxLines,
    this.minFontSize = 12,
    this.overflow,
    this.overflowReplacement,
    this.presetFontSizes,
    this.semanticsLabel,
    this.softWrap,
    this.stepGranularity = 1,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textKey,
    this.textScaleFactor,
    this.wrapWords = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        ThemedText.styleForVariant(this.variant).merge(this.style);
    return AutoSizeText(
      this.data,
      group: this.group,
      locale: this.locale,
      maxFontSize: this.maxFontSize,
      maxLines: this.maxLines,
      minFontSize: this.minFontSize,
      overflow: this.overflow,
      overflowReplacement: this.overflowReplacement,
      presetFontSizes: this.presetFontSizes,
      semanticsLabel: this.semanticsLabel,
      softWrap: this.softWrap,
      stepGranularity: this.stepGranularity,
      strutStyle: this.strutStyle,
      style: style,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      textKey: this.textKey,
      textScaleFactor: this.textScaleFactor,
      wrapWords: this.wrapWords,
    );
  }
}
