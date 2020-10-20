import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePageInformationCard extends StatelessWidget {
  final String buttonText;
  final RouteLink link;
  final String subtitle;
  final String title;
  final String imageName;

  String get assetName =>
      imageName != null ? 'assets/svg/${imageName}.svg' : null;

  const HomePageInformationCard({
    @required this.buttonText,
    @required this.link,
    @required this.subtitle,
    @required this.title,
    this.imageName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inner = _HomePageInformationCardInner(
      buttonText: buttonText,
      link: link,
      subtitle: subtitle,
      title: title,
    );
    return assetName != null
        ? Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: inner,
              ),
              Positioned(
                right: 28.0,
                child:
                    Container(height: 96, child: SvgPicture.asset(assetName)),
              )
            ],
          )
        : inner;
  }
}

class _HomePageInformationCardInner extends StatelessWidget {
  final String buttonText;
  final RouteLink link;
  final String subtitle;
  final String title;

  const _HomePageInformationCardInner({
    @required this.buttonText,
    @required this.link,
    @required this.subtitle,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Button(
        backgroundColor: Constants.illustrationBlue1Color,
        onPressed: () {
          return link.open(context);
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.0, 36.0, 12.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ThemedText(
                title,
                variant: TypographyVariant.h3,
                style: TextStyle(
                  color: Constants.primaryDarkColor,
                ),
              ),
              Container(
                height: 6.0,
              ),
              ThemedText(
                subtitle,
                variant: TypographyVariant.body,
                style: TextStyle(
                  color: Constants.neutralTextDarkColor,
                ),
              ),
              Container(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Button(
                    backgroundColor: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
