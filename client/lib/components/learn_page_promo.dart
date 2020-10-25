import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/promo_curved_background.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

const shadow = Shadow(
  blurRadius: 20.0,
);

// 4X shadows is used to make it more opaque and offset from the background
const opaqueShadow = <Shadow>[
  shadow,
  shadow,
  shadow,
  shadow,
];

class LearnPagePromo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final RouteLink link;
  final String imageName;

  String get assetName {
    return imageName != null ? 'assets/svg/${imageName}.svg' : null;
  }

  const LearnPagePromo(
      {Key key,
      this.title,
      this.subtitle,
      this.buttonText,
      this.link,
      this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned.fill(
          child: PromoCurvedBackground(
            color: Constants.primaryDarkColor,
          ),
        ),
        if (assetName != null)
          Positioned.fill(child: FittedBox(child: SvgPicture.asset(assetName))),
        SafeArea(
            bottom: false,
            child: Container(
              child: Column(children: [
                SizedBox(
                  height: 24.0,
                ),
                ThemedText(
                  title,
                  variant: TypographyVariant.h3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    shadows: opaqueShadow,
                  ),
                ),
                ThemedText(
                  subtitle,
                  variant: TypographyVariant.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.white,
                    shadows: opaqueShadow,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Button(
                  backgroundColor: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(50),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                  buttonType: ButtonType.Elevated,
                  child: ThemedText(
                    buttonText,
                    variant: TypographyVariant.button,
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    return link.open(context);
                  },
                ),
                SizedBox(
                  height: 80.0,
                )
              ]),
            ))
      ],
    );
  }
}
