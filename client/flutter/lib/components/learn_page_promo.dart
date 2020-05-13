import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/promo_curved_background.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class LearnPagePromo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final RouteLink link;
  final String imageName;

  String get assetName {
    return this.imageName != null ? 'assets/svg/${this.imageName}.svg' : null;
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
        if (this.assetName != null)
          Positioned.fill(
              child: FittedBox(child: SvgPicture.asset(this.assetName))),
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
                  ),
                ),
                ThemedText(
                  subtitle,
                  variant: TypographyVariant.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                CupertinoButton(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(50),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                  child: ThemedText(
                    buttonText,
                    variant: TypographyVariant.button,
                    style: TextStyle(
                      color: Constants.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    return this.link.open(context);
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
