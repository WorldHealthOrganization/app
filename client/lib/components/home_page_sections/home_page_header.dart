import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/promo_curved_background.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePageHeader extends StatelessWidget {
  final IndexPromoType headerType;
  final String title;
  final String subtitle;
  final String buttonText;
  final RouteLink link;
  final String imageName;

  const HomePageHeader({
    @required this.headerType,
    @required this.title,
    @required this.subtitle,
    @required this.buttonText,
    @required this.link,
    this.imageName,
  });

  String get svgAssetName {
    return imageName != null ? 'assets/svg/${imageName}.svg' : null;
  }

  Color get backgroundColor {
    // switch (this.headerType) {
    //   case IndexPromoType.CheckYourSymptoms:
    //     return Constants.primaryDarkColor;
    //   case IndexPromoType.ProtectYourself:
    //     return Constants.accentTealColor;
    //   default:
    //     return Constants.primaryDarkColor;
    // }

    // Avoiding mistakes in v1 by not making this configurable
    return Constants.primaryDarkColor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Positioned.fill(
          child: PromoCurvedBackground(
            color: backgroundColor,
          ),
        ),
        SafeArea(
          bottom: false,
          child: Container(
            padding: EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _LogoRow(),
                Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: svgAssetName != null
                          ? SvgPicture.asset(svgAssetName)
                          : Container(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24.0, right: 72.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 28.0),
                            child: AutoSizeThemedText(
                              title,
                              variant: TypographyVariant.title,
                              maxFontSize: 40,
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ThemedText(
                              subtitle,
                              variant: TypographyVariant.body,
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 32.0, bottom: 88.0),
                            child: Button(
                              borderRadius: BorderRadius.circular(50),
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              backgroundColor: CupertinoColors.white,
                              child: Container(
                                child: ThemedText(
                                  buttonText,
                                  variant: TypographyVariant.button,
                                  style:
                                      TextStyle(color: Constants.primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onPressed: () {
                                return link.open(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _LogoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 12.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 112.0,
              height: 34.0,
              child: SvgPicture.asset('assets/svg/who-logo-white.svg'),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 14.0,
              ),
              color: Constants.homeHeaderGreenColor.withOpacity(0.5),
              height: double.infinity,
              width: 1.0,
            ),
            Expanded(
              child: Text(
                // TODO: Localize
                'COVID-19 Response',
                style: TextStyle(
                  color: Constants.homeHeaderGreenColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.57,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
