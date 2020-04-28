import 'package:flutter/cupertino.dart';

// import '../constants.dart';

enum TypographyVariant { title, h1, h2, h3, h4, body, button, bodySmall }

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
    Key key,
    @required this.variant,
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

  static final Map<TypographyVariant, TextStyle> variantStyles = {
    TypographyVariant.title: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.w900,
      fontSize: 48,
      height: 1.0,
    ),
    TypographyVariant.h1: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.w900,
      fontSize: 40,
      height: 1.0,
    ),
    TypographyVariant.h2: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.bold,
      fontSize: 30,
      height: 1.2,
      letterSpacing: -0.0011,
    ),
    TypographyVariant.h3: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
      height: 1.167,
    ),
    TypographyVariant.h4: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      height: 1.333,
      letterSpacing: 0.18,
    ),
    TypographyVariant.body: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 1.375,
      letterSpacing: -0.32,
    ),
    TypographyVariant.button: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.222,
    ),
    TypographyVariant.bodySmall: TextStyle(
      // color: Constants.typographyColor,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 1.43,
    ),
  };

  @override
  Widget build(BuildContext context) {
    TextStyle style = ThemedText.variantStyles[this.variant].merge(this.style);
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
