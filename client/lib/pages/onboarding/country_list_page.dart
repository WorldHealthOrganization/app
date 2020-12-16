import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/iso_country.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class CountryListPage extends StatefulWidget {
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
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  String selectedCountryCode;
  Iterable<IsoCountry> selectedCountries;

  @override
  void initState() {
    super.initState();
    selectedCountryCode = widget.selectedCountryCode;
    listData = (widget.countries?.values ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      // TODO: localize?
      // title: 'Country',
      headerWidget: TextField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter your country'),
          onChanged: (String value) async {
            List filtered = (widget.countries?.values ?? []).where((element) {
              var nameMatch = element.name
                  .toString()
                  .toUpperCase()
                  .contains(value.toUpperCase());
              if (listItem || selectedCountryCode == element.alpha2Code) {
                return true;
              }
              return false;
            }).toList();
            setState(() {
              listData = filtered;
            });
          }),
      color: Constants.backgroundColor,
      body: _buildCountries(listData),
    );
  }

  List<Widget> _buildCountries(listData) {
    if (widget.countries == null || widget.countries.isEmpty) {
      return [LoadingIndicator()];
    }
    return (listData)
        .map<Widget>((country) => _buildCountryItem(country))
        .toList();
  }

  Widget _buildCountryItem(IsoCountry country) {
    return SliverToBoxAdapter(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            setState(() {
              selectedCountryCode = country.alpha2Code;
            });
            await widget.onCountrySelected(
              country,
            );
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
                  if (selectedCountryCode == country.alpha2Code)
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
