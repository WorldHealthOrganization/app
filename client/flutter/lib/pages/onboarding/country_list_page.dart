import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/iso_country.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class CountryListPage extends StatelessWidget {
  final String selectedCountryCode;
  final Function onBack;
  final Function onCountrySelected;
  final Map<String, IsoCountry> countries;

  const CountryListPage({
    @required this.onBack,
    @required this.onCountrySelected,
    @required this.countries,
    this.selectedCountryCode,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: this.onBack,
          color: Constants.accentNavyColor,
        ),
        // TODO: localize?
        middle: PageHeader.buildTitle('Country',
            variant: TypographyVariant.headerSmall),
        transitionBetweenRoutes: false,
      ),
      child: Material(
        child: CustomScrollView(
          slivers: <Widget>[..._buildCountries()],
        ),
      ),
    );
  }

  List<Widget> _buildCountries() {
    if (this.countries == null || this.countries.isEmpty) {
      return [LoadingIndicator()];
    }
    return (this.countries?.values ?? [])
        .map((country) => _buildCountryItem(country))
        .toList();
  }

  Widget _buildCountryItem(IsoCountry country) {
    return SliverToBoxAdapter(
      child: Material(
        color: CupertinoColors.white,
        child: InkWell(
          onTap: () async {
            await this.onCountrySelected(country);
          },
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ThemedText(
                        country.name,
                        variant: TypographyVariant.button,
                        style: TextStyle(
                          color: Constants.neutral2Color,
                          height: 28.0 / 16.0,
                        ),
                      ),
                    ),
                  ),
                  if (this.selectedCountryCode == country.alpha2Code)
                    Container(
                      padding:
                          EdgeInsets.only(top: 16.0, bottom: 16.0, right: 12.0),
                      child: FaIcon(
                        FontAwesomeIcons.solidCheckCircle,
                        color: Constants.successCheckColor,
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Container(
                  height: 0.5,
                  color: Constants.neutral3Color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
