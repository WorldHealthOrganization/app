import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class CountrySelectPage extends StatelessWidget {
  final String countryName;
  final Function onOpenCountryList;
  final Function onNext;

  const CountrySelectPage({
    @required this.onOpenCountryList,
    @required this.onNext,
    this.countryName,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 36.0, bottom: 18.0),
              // Uncomment below when SVG asset is ready to be included
              // child: SvgPicture.asset(
              //     'assets/svg/streamline-onboarding-location.svg'),
              // Remove below when SVG asset is ready to be included
              child: Container(
                height: 145.0,
                width: 145.0,
                color: Constants.illustrationPinkColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 36.0, right: 20.0, bottom: 18.0),
                child: ThemedText(
                  S.of(context).locationSharingPageTitle,
                  variant: TypographyVariant.h2,
                  style: TextStyle(
                    color: Constants.primaryDarkColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 36.0, right: 54.0, bottom: 42.0),
                child: ThemedText(
                  S.of(context).locationSharingPageDescription,
                  variant: TypographyVariant.body,
                  style: TextStyle(
                    color: Constants.neutral1Color,
                  ),
                ),
              ),
              _buildOpenListRow(),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 112.0),
                child: Material(
                  child: FlatButton(
                    onPressed: this.countryName != null ? this.onNext : null,
                    color: Constants.whoBackgroundBlueColor,
                    disabledColor:
                        Constants.neutralTextLightColor.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    // TODO: localize
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                      child: ThemedText(
                        'Next',
                        variant: TypographyVariant.button,
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpenListRow() {
    return Material(
      color: CupertinoColors.white,
      child: InkWell(
        onTap: this.onOpenCountryList,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Constants.neutral3Color,
              width: 0.5,
            ),
            top: BorderSide(
              color: Constants.neutral3Color,
              width: 0.5,
            ),
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                // TODO: localize
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 24.0, left: 16.0),
                  child: ThemedText(
                    'Country',
                    variant: TypographyVariant.button,
                    style: TextStyle(
                      color: Constants.neutralTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 24.0,
                  ),
                  // TODO: localize
                  child: ThemedText(
                    this.countryName ?? 'Select',
                    variant: TypographyVariant.body,
                    style: TextStyle(
                      color: this.countryName != null
                          ? Constants.neutralTextColor
                          : Constants.emergencyRedColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                  bottom: 24.0,
                  right: 12.0,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Constants.neutral3Color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
