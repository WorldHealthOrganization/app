import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/iso_country.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class CountryListPage extends StatefulWidget {
  final String selectedCountryCode;
  final Function onBack;
  final Function onCountrySelected;

  const CountryListPage({
    @required this.onBack,
    @required this.onCountrySelected,
    this.selectedCountryCode,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryListState();
}

class _CountryListState extends State<CountryListPage> {
  Map<String, IsoCountry> _countries;

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  void getCountries() async {
    await IsoCountryList().loadCountries();
    _countries = IsoCountryList().countries;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: this.widget.onBack,
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
    if (_countries == null || _countries.isEmpty) {
      return [LoadingIndicator()];
    }
    return _countries.values
        .map((country) => _buildCountryItem(country))
        .toList();
  }

  Widget _buildCountryItem(IsoCountry country) {
    return SliverToBoxAdapter(
      child: Material(
        color: CupertinoColors.white,
        child: InkWell(
          onTap: () async {
            await this.widget.onCountrySelected(country);
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
                  if (this.widget.selectedCountryCode == country.alpha2Code)
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
