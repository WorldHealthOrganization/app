import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/linking.dart';
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
    return this.imageName != null ? 'assets/svg/${this.imageName}.svg' : null;
  }

  Color get backgroundColor {
    switch (this.headerType) {
      case IndexPromoType.CheckYourSymptoms:
        return Constants.primaryDarkColor;
      case IndexPromoType.ProtectYourself:
        return Constants.accentTealColor;
      default:
        return Constants.primaryDarkColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Positioned.fill(
          child: PromoCurvedBackground(
            color: this.backgroundColor,
          ),
        ),
        SafeArea(
          bottom: false,
          child: _buildForeground(context),
        )
      ],
    );
  }

  Widget _buildForeground(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildLogoSection(),
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: this.svgAssetName != null
                    ? SvgPicture.asset(this.svgAssetName)
                    : Container(),
              ),
              Container(
                padding: EdgeInsets.only(left: 24.0, right: 72.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 28.0),
                      child: ThemedText(
                        this.title,
                        variant: TypographyVariant.title,
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ThemedText(
                        this.subtitle,
                        variant: TypographyVariant.body,
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0, bottom: 88.0),
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(50),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 8,
                        ),
                        color: CupertinoColors.white,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: 180,
                            maxWidth: 300,
                          ),
                          child: ThemedText(
                            this.buttonText,
                            variant: TypographyVariant.button,
                            style: TextStyle(color: Constants.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () {
                          return this.link.open(context);
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
    );
  }

  Widget _buildLogoSection() {
    return Container(
      constraints: BoxConstraints(minHeight: 48.0),
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: CupertinoColors.white,
              width: 48.0,
              margin: EdgeInsets.only(right: 8),
              // TODO: Add WHO logo
              // child: ,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 14.0,
              ),
              color: Color.fromARGB(127, 250, 232, 169),
              width: 1.0,
            ),
            Center(
              child: Text(
                // TODO: Localize
                'COVID-19 Response',
                style: TextStyle(
                  color: Color(0xffFAE8A9),
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
