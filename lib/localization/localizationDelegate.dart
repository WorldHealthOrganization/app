import 'package:flutter/material.dart';
import 'dart:async';
import './localization.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {


  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'ar', 'zh', 'ru','es'].contains(locale.languageCode);
  }

  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;

  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}