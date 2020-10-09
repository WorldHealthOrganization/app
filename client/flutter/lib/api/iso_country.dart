import 'dart:core';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

class IsoCountryList {
  final Map<String, IsoCountry> _countries;
  Map<String, IsoCountry> get countries => _countries;

  static const isoFilePath = 'assets/onboarding/iso_countries.en.yaml';

  IsoCountryList._(this._countries);

  IsoCountryList.empty() : this._({});

  static Future<Map<String, IsoCountry>> _countriesFromYaml(
      String csvPath) async {
    var countries = <String, IsoCountry>{};
    final yamlString = await rootBundle.loadString(IsoCountryList.isoFilePath);
    final yaml = loadYaml(yamlString);
    yaml['countries'].forEach((countryYaml) {
      final country = IsoCountry(
        name: countryYaml['name'],
        alpha2Code: countryYaml['alpha_2_code'],
      );
      countries[country.alpha2Code] = country;
    });
    return countries;
  }

  static Future<IsoCountryList> load() async {
    Map<String, IsoCountry> countries;
    try {
      countries = await _countriesFromYaml(IsoCountryList.isoFilePath);
      return IsoCountryList._(countries);
    } catch (error) {
      print('Error loading countries: $error');
    }
    return IsoCountryList.empty();
  }
}

class IsoCountry {
  final String name;
  final String alpha2Code;

  // https://en.wikipedia.org/wiki/Regional_indicator_symbol
  static final regionalIndicatorOffset = 0x1F1E6 - 'A'.codeUnits.single;
  String get emoji {
    return String.fromCharCodes(
        alpha2Code.codeUnits.map((c) => c + regionalIndicatorOffset));
  }

  static final alpha2CodeRe = RegExp('^[A-Z][A-Z]\$');

  IsoCountry({
    @required this.name,
    @required this.alpha2Code,
  }) : assert(alpha2CodeRe.hasMatch(alpha2Code));
}
