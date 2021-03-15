// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserPreferencesStore on _UserPreferencesStore, Store {
  final _$obsCountryIsoCodeAtom =
      Atom(name: '_UserPreferencesStore.obsCountryIsoCode');

  @override
  String get obsCountryIsoCode {
    _$obsCountryIsoCodeAtom.reportRead();
    return super.obsCountryIsoCode;
  }

  @override
  set obsCountryIsoCode(String value) {
    _$obsCountryIsoCodeAtom.reportWrite(value, super.obsCountryIsoCode, () {
      super.obsCountryIsoCode = value;
    });
  }

  final _$obsSavedLocationAtom =
      Atom(name: '_UserPreferencesStore.obsSavedLocation');

  @override
  Place get obsSavedLocation {
    _$obsSavedLocationAtom.reportRead();
    return super.obsSavedLocation;
  }

  @override
  set obsSavedLocation(Place value) {
    _$obsSavedLocationAtom.reportWrite(value, super.obsSavedLocation, () {
      super.obsSavedLocation = value;
    });
  }

  final _$setCountryIsoCodeAsyncAction =
      AsyncAction('_UserPreferencesStore.setCountryIsoCode');

  @override
  Future<bool> setCountryIsoCode(String newValue) {
    return _$setCountryIsoCodeAsyncAction
        .run(() => super.setCountryIsoCode(newValue));
  }

  final _$setSavedLocationAsyncAction =
      AsyncAction('_UserPreferencesStore.setSavedLocation');

  @override
  Future<bool> setSavedLocation(Place newValue) {
    return _$setSavedLocationAsyncAction
        .run(() => super.setSavedLocation(newValue));
  }

  @override
  String toString() {
    return '''
obsCountryIsoCode: ${obsCountryIsoCode},
obsSavedLocation: ${obsSavedLocation}
    ''';
  }
}
