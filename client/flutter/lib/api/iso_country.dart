import 'dart:core';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

class IsoCountryList {
  Map<String, IsoCountry> _countries;
  Map<String, IsoCountry> get countries => _countries;

  static const isoFilePath = 'assets/onboarding/iso_countries.en.yaml';

  static final IsoCountryList _singleton = IsoCountryList._internal();

  factory IsoCountryList() {
    return _singleton;
  }

  IsoCountryList._internal();

  static Future<Map<String, IsoCountry>> _countriesFromYaml(
      String csvPath) async {
    Map<String, IsoCountry> countries = {};
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

  Future<bool> loadCountries() async {
    if (_countries?.isNotEmpty ?? false) {
      return true;
    }
    try {
      _countries = await _countriesFromYaml(IsoCountryList.isoFilePath);
      return true;
    } catch (error) {
      print('Error loading countries: $error');
    }
    return false;
  }
}

class IsoCountry {
  final String name;
  final String alpha2Code;

  const IsoCountry({
    @required this.name,
    @required this.alpha2Code,
  });
}
