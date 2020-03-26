// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S(this.localeName);

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S(localeName);
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  final String localeName;

  String get worldHealthOrganization {
    return Intl.message(
      'World Health Organization',
      name: 'worldHealthOrganization',
      desc: '',
      args: [],
    );
  }

  String get learnMore {
    return Intl.message(
      'Learn more',
      name: 'learnMore',
      desc: '',
      args: [],
    );
  }

  String get protectYourself {
    return Intl.message(
      'Protect yourself',
      name: 'protectYourself',
      desc: '',
      args: [],
    );
  }

  String get checkYourHealth {
    return Intl.message(
      'Check your health',
      name: 'checkYourHealth',
      desc: '',
      args: [],
    );
  }

  String get localMaps {
    return Intl.message(
      'Local Maps',
      name: 'localMaps',
      desc: '',
      args: [],
    );
  }

  String get shareTheApp {
    return Intl.message(
      'Share the App',
      name: 'shareTheApp',
      desc: '',
      args: [],
    );
  }

  String get healthCheck {
    return Intl.message(
      'Health Check',
      name: 'healthCheck',
      desc: '',
      args: [],
    );
  }

  String get feelingDistressed {
    return Intl.message(
      'Feeling Distressed?',
      name: 'feelingDistressed',
      desc: '',
      args: [],
    );
  }

  String get washHands {
    return Intl.message(
      'Wash your hand often with soap and running water frequently',
      name: 'washHands',
      desc: '',
      args: [],
    );
  }

  String get cougningAndSneezing {
    return Intl.message(
      'When coughing and sneezing cover mouth and nose with flexed elbow or tissue',
      name: 'cougningAndSneezing',
      desc: '',
      args: [],
    );
  }

  String get throwAwayTissue {
    return Intl.message(
      'Throw tissue into closed bin immediately after use',
      name: 'throwAwayTissue',
      desc: '',
      args: [],
    );
  }

  String get washHandsFrequently {
    return Intl.message(
      'Wash your hands frequently',
      name: 'washHandsFrequently',
      desc: '',
      args: [],
    );
  }

  String get socialDistancing {
    return Intl.message(
      'Avoid close contact and keep the physical distancing',
      name: 'socialDistancing',
      desc: '',
      args: [],
    );
  }

  String get seekMedicalCare {
    return Intl.message(
      'Seek medical care early if you have fever, cough, and difficulty breathing',
      name: 'seekMedicalCare',
      desc: '',
      args: [],
    );
  }

  String get infoForEveryone {
    return Intl.message(
      'Information for Everyone',
      name: 'infoForEveryone',
      desc: '',
      args: [],
    );
  }

  String get infoForParents {
    return Intl.message(
      'Information for Parents',
      name: 'infoForParents',
      desc: '',
      args: [],
    );
  }

  String get childStress {
    return Intl.message(
      'Children may respond to stress in different ways such as being more clingy, anxious, withdraw, angry or agitated, bedwetting etc\nRespind to your child\'s reactions in a supportive way, listen to their concerns and give them extra love and attention.',
      name: 'childStress',
      desc: '',
      args: [],
    );
  }

  String get childLove {
    return Intl.message(
      'Children need adults\' love and attention during difficult times. Give them extra time and attention.\nRemember to listen to your children, speak kindly and reasure.\nIf possible, make opportunities for the child to play and relax.',
      name: 'childLove',
      desc: '',
      args: [],
    );
  }

  String get childDistance {
    return Intl.message(
      'Try and keep children close to their parents and family and avoid separating children and their caregivers to the extent possible. If separation occurs (e.g. hospitalization) ensure regular contact (e.g. via phone) and re-assurance.',
      name: 'childDistance',
      desc: '',
      args: [],
    );
  }

  String get childRoutines {
    return Intl.message(
      'Keep to regular routines and schedules as much as possible, or help create new ones in a new environment, including school/learning as well as time for safely playing and relaxing.',
      name: 'childRoutines',
      desc: '',
      args: [],
    );
  }

  String get childFacts {
    return Intl.message(
      'Provide facts about what has happened, explain what is going on now and give them clear information about how to reduce their risk of being infected by the disease in words that they can understand depending on their age.\nThis also includes providing information about what could happen in a re-assuring way (e.g. a family member and/or the child may start not feeling well and may have to go to the hospital for some time so doctors can help them feel better).',
      name: 'childFacts',
      desc: '',
      args: [],
    );
  }

  String get whoMythBusters {
    return Intl.message(
      'WHO Myth-busters',
      name: 'whoMythBusters',
      desc: '',
      args: [],
    );
  }

  String get travelAdvice {
    return Intl.message(
      'Travel Advice',
      name: 'travelAdvice',
      desc: '',
      args: [],
    );
  }

  String get aboutTheApp {
    return Intl.message(
      'About the App',
      name: 'aboutTheApp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('es', ''),
      Locale('ar', ''),
      Locale('zh', ''),
      Locale('en', ''),
      Locale('ru', ''),
      Locale('fr', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
