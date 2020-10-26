// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get commonWorldHealthOrganization {
    return Intl.message(
      'World Health Organization',
      name: 'commonWorldHealthOrganization',
      desc: '',
      args: [],
    );
  }

  String get commonWorldHealthOrganizationCoronavirusApp {
    return Intl.message(
      'COVID-19',
      name: 'commonWorldHealthOrganizationCoronavirusApp',
      desc: '',
      args: [],
    );
  }

  String get commonWhoAppShareIconButtonDescription {
    return Intl.message(
      'Check out the official COVID-19 app from the World Health Organization https://whoapp.org/app',
      name: 'commonWhoAppShareIconButtonDescription',
      desc: '',
      args: [],
    );
  }

  String commonWorldHealthOrganizationCoronavirusAppVersion(
      Object version, Object buildNumber) {
    return Intl.message(
      'Version $version ($buildNumber)',
      name: 'commonWorldHealthOrganizationCoronavirusAppVersion',
      desc: '',
      args: [version, buildNumber],
    );
  }

  String commonWorldHealthOrganizationCoronavirusCopyright(Object year) {
    return Intl.message(
      '© $year WHO',
      name: 'commonWorldHealthOrganizationCoronavirusCopyright',
      desc: '',
      args: [year],
    );
  }

  String get commonPermissionRequestPageButtonSkip {
    return Intl.message(
      'Skip',
      name: 'commonPermissionRequestPageButtonSkip',
      desc: '',
      args: [],
    );
  }

  String get commonDialogButtonOk {
    return Intl.message(
      'OK',
      name: 'commonDialogButtonOk',
      desc: '',
      args: [],
    );
  }

  String get commonContentLoadingDialogUpdateRequiredTitle {
    return Intl.message(
      'App Update Required',
      name: 'commonContentLoadingDialogUpdateRequiredTitle',
      desc: '',
      args: [],
    );
  }

  String get commonContentLoadingDialogUpdateRequiredBodyText {
    return Intl.message(
      'Please update to the latest version of the app in order to receive the latest information and updates.',
      name: 'commonContentLoadingDialogUpdateRequiredBodyText',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPageTitle {
    return Intl.message(
      'Official WHO COVID-19 Information App',
      name: 'legalLandingPageTitle',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPageButtonGetStarted {
    return Intl.message(
      'Get Started',
      name: 'legalLandingPageButtonGetStarted',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPageButtonAgree {
    return Intl.message(
      'By proceeding, you agree to our\n',
      name: 'legalLandingPageButtonAgree',
      desc: '',
      args: [],
    );
  }

  String get LegalLandingPageTermsOfServiceLinkText {
    return Intl.message(
      'Terms of Service',
      name: 'LegalLandingPageTermsOfServiceLinkText',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPageTermsOfServiceLinkUrl {
    return Intl.message(
      'https://www.who.int/myhealthapp/terms-of-use',
      name: 'legalLandingPageTermsOfServiceLinkUrl',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPageAnd {
    return Intl.message(
      ' and ',
      name: 'legalLandingPageAnd',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPagePrivacyPolicyLinkText {
    return Intl.message(
      'Privacy Policy',
      name: 'legalLandingPagePrivacyPolicyLinkText',
      desc: '',
      args: [],
    );
  }

  String get legalLandingPagePrivacyPolicyLinkUrl {
    return Intl.message(
      'https://www.who.int/myhealthapp/privacy-notice',
      name: 'legalLandingPagePrivacyPolicyLinkUrl',
      desc: '',
      args: [],
    );
  }

  String get locationSharingPageTitle {
    return Intl.message(
      'Get the latest news from your community',
      name: 'locationSharingPageTitle',
      desc: '',
      args: [],
    );
  }

  String get locationSharingPageDescription {
    return Intl.message(
      'To get local news and information, select your home country.',
      name: 'locationSharingPageDescription',
      desc: '',
      args: [],
    );
  }

  String get locationSharingPageButton {
    return Intl.message(
      'Allow Location Sharing',
      name: 'locationSharingPageButton',
      desc: '',
      args: [],
    );
  }

  String get notificationsPagePermissionRequestPageTitle {
    return Intl.message(
      'Stay up to date on COVID-19',
      name: 'notificationsPagePermissionRequestPageTitle',
      desc: '',
      args: [],
    );
  }

  String get notificationsPagePermissionRequestPageDescription {
    return Intl.message(
      'To stay up to date with COVID-19 news, turn on app notifications from the World Health Organization.',
      name: 'notificationsPagePermissionRequestPageDescription',
      desc: '',
      args: [],
    );
  }

  String get notificationsPagePermissionRequestPageButton {
    return Intl.message(
      'Allow Notifications',
      name: 'notificationsPagePermissionRequestPageButton',
      desc: '',
      args: [],
    );
  }

  String get homePagePageTitle {
    return Intl.message(
      'COVID-19',
      name: 'homePagePageTitle',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSubTitle {
    return Intl.message(
      'Information & tools',
      name: 'homePagePageSubTitle',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonQuestions {
    return Intl.message(
      'Questions & Answers',
      name: 'homePagePageButtonQuestions',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonProtectYourself {
    return Intl.message(
      'Protect Yourself',
      name: 'homePagePageButtonProtectYourself',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonLatestNumbers {
    return Intl.message(
      'Latest Numbers',
      name: 'homePagePageButtonLatestNumbers',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonYourQuestionsAnswered {
    return Intl.message(
      'Questions & Answers',
      name: 'homePagePageButtonYourQuestionsAnswered',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonWHOMythBusters {
    return Intl.message(
      'Get the Facts',
      name: 'homePagePageButtonWHOMythBusters',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonNewsAndPress {
    return Intl.message(
      'News & Press',
      name: 'homePagePageButtonNewsAndPress',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonWHOMythBustersDescription {
    return Intl.message(
      'Learn the facts about COVID-19 and how to prevent the spread',
      name: 'homePagePageButtonWHOMythBustersDescription',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonTravelAdvice {
    return Intl.message(
      'Travel Advice',
      name: 'homePagePageButtonTravelAdvice',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListShareTheApp {
    return Intl.message(
      'Share the app',
      name: 'homePagePageSliverListShareTheApp',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListProvideFeedback {
    return Intl.message(
      'Provide App Feedback',
      name: 'homePagePageSliverListProvideFeedback',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSettingsHeader1 {
    return Intl.message(
      'Analytics',
      name: 'homePagePageSliverListSettingsHeader1',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSettingsHeader2 {
    return Intl.message(
      'Language',
      name: 'homePagePageSliverListSettingsHeader2',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSettings {
    return Intl.message(
      'Settings',
      name: 'homePagePageSliverListSettings',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSettingsDataCollection {
    return Intl.message(
      'Allow WHO to collect analytics for product improvement using Google Analytics',
      name: 'homePagePageSliverListSettingsDataCollection',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSettingsNotificationsHeader {
    return Intl.message(
      'Notifications',
      name: 'homePagePageSliverListSettingsNotificationsHeader',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSettingsNotificationsInfo {
    return Intl.message(
      'Allow WHO to send you notifications to inform you of updates',
      name: 'homePagePageSliverListSettingsNotificationsInfo',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListAboutTheApp {
    return Intl.message(
      'About the app',
      name: 'homePagePageSliverListAboutTheApp',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListAboutTheAppDialog {
    return Intl.message(
      'The official World Health Organization COVID-19 App.',
      name: 'homePagePageSliverListAboutTheAppDialog',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListSupport {
    return Intl.message(
      'Help support the\nrelief effort',
      name: 'homePagePageSliverListSupport',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListDonate {
    return Intl.message(
      'Donate Here',
      name: 'homePagePageSliverListDonate',
      desc: '',
      args: [],
    );
  }

  String get homePagePageSliverListDonateUrl {
    return Intl.message(
      'https://covid19responsefund.org/',
      name: 'homePagePageSliverListDonateUrl',
      desc: '',
      args: [],
    );
  }

  String get homePagePageButtonLatestNumbersUrl {
    return Intl.message(
      'https://who.sprinklr.com',
      name: 'homePagePageButtonLatestNumbersUrl',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfTitle {
    return Intl.message(
      'Protect Yourself',
      name: 'protectYourselfTitle',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfHeader {
    return Intl.message(
      'General Recommendations',
      name: 'protectYourselfHeader',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfListOfItemsPageListItem1 {
    return Intl.message(
      '*Wash your hands* with soap and water to avoid getting sick and spreading infections to others',
      name: 'protectYourselfListOfItemsPageListItem1',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfListOfItemsPageListItem2 {
    return Intl.message(
      '*Avoid touching* your eyes, mouth, and nose',
      name: 'protectYourselfListOfItemsPageListItem2',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfListOfItemsPageListItem3 {
    return Intl.message(
      '*Cover your mouth and nose* with your bent elbow or tissue when you cough or sneeze',
      name: 'protectYourselfListOfItemsPageListItem3',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfListOfItemsPageListItem4 {
    return Intl.message(
      '*Stay more than* 1 meter (>3 feet) away from a person who is sick',
      name: 'protectYourselfListOfItemsPageListItem4',
      desc: '',
      args: [],
    );
  }

  String get protectYourselfListOfItemsPageListItem5 {
    return Intl.message(
      'Only wear a mask if you or someone you are looking after are ill with COVID-19 symptoms (especially coughing)',
      name: 'protectYourselfListOfItemsPageListItem5',
      desc: '',
      args: [],
    );
  }

  String get travelAdviceContainerText {
    return Intl.message(
      '<p>WHO continues to <b>advise against the application of travel or trade restrictions</b> to countries experiencing COVID-19 outbreaks.</p> <p><b>It is prudent for travellers who are sick to delay or avoid travel to affected areas</b>, in particular for elderly travellers and people with chronic diseases or underlying health conditions. “Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contract to areas reporting only imported cases.</p>',
      name: 'travelAdviceContainerText',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageListTitle {
    return Intl.message(
      'Travellers returning from affected areas should:',
      name: 'travelAdvicePageListTitle',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageListItem1Text {
    return Intl.message(
      'Self-monitor for symptoms for 14 days and follow national protocols of receiving countries.',
      name: 'travelAdvicePageListItem1Text',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageListItem2Text {
    return Intl.message(
      'Some countries may require returning travellers to enter quarantine.',
      name: 'travelAdvicePageListItem2Text',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageListItem3Text {
    return Intl.message(
      'If symptoms occur, travellers are advised to contact local health care providers, preferably by phone, and inform them of their symptoms and travel history.',
      name: 'travelAdvicePageListItem3Text',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageButtonGeneralRecommendations {
    return Intl.message(
      'General Recommendations',
      name: 'travelAdvicePageButtonGeneralRecommendations',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageButtonGeneralRecommendationsLink {
    return Intl.message(
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019',
      name: 'travelAdvicePageButtonGeneralRecommendationsLink',
      desc: '',
      args: [],
    );
  }

  String get travelAdvicePageButtonGeneralRecommendationsDescription {
    return Intl.message(
      'Learn the facts about COVID-19 and how to prevent the spread',
      name: 'travelAdvicePageButtonGeneralRecommendationsDescription',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem1 {
    return Intl.message(
      'There is a lot of false information around. These are the facts',
      name: 'whoMythBustersListOfItemsPageListItem1',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem2 {
    return Intl.message(
      'People of all ages CAN be infected by the coronavirus. Older people, and people with pre-existing medical conditions (such as asthma, diabetes, heart disease) appear to be more vulnerable to becoming severely ill with the virus',
      name: 'whoMythBustersListOfItemsPageListItem2',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem3 {
    return Intl.message(
      'Cold weather and snow CANNOT kill the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem3',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem4 {
    return Intl.message(
      'The coronavirus CAN be transmitted in areas with hot and humid climates',
      name: 'whoMythBustersListOfItemsPageListItem4',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem5 {
    return Intl.message(
      'The coronavirus CANNOT be transmitted through mosquito bites',
      name: 'whoMythBustersListOfItemsPageListItem5',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem6 {
    return Intl.message(
      'There is NO evidence that companion animals/pets such as dogs or cats can transmit the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem6',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem7 {
    return Intl.message(
      'Taking a hot bath DOES NOT prevent the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem7',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem8 {
    return Intl.message(
      'Hand dryers are NOT effective in killing the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem8',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem9 {
    return Intl.message(
      'Ultraviolet light SHOULD NOT be used for sterilization and can cause skin irritation',
      name: 'whoMythBustersListOfItemsPageListItem9',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem10 {
    return Intl.message(
      'Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem10',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem11 {
    return Intl.message(
      'Spraying alcohol or chlorine all over your body WILL NOT kill viruses that have already entered your body',
      name: 'whoMythBustersListOfItemsPageListItem11',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem12 {
    return Intl.message(
      'Vaccines against pneumonia, such as pneumococcal vaccine and Haemophilus influenzae type b (Hib) vaccine, DO NOT provide protection against the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem12',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem13 {
    return Intl.message(
      'There is NO evidence that regularly rinsing the nose with saline has protected people from infection with the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem13',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem14 {
    return Intl.message(
      'Garlic is healthy but there is NO evidence from the current outbreak that eating garlic has protected people from the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem14',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem15 {
    return Intl.message(
      'Antibiotics DO NOT work against viruses, antibiotics only work against bacteria',
      name: 'whoMythBustersListOfItemsPageListItem15',
      desc: '',
      args: [],
    );
  }

  String get whoMythBustersListOfItemsPageListItem16 {
    return Intl.message(
      'To date, there is NO specific medicine recommended to prevent or treat the coronavirus',
      name: 'whoMythBustersListOfItemsPageListItem16',
      desc: '',
      args: [],
    );
  }

  String get newsFeedTitle {
    return Intl.message(
      'News & Press',
      name: 'newsFeedTitle',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemTitle1 {
    return Intl.message(
      'Situation Reports',
      name: 'newsFeedSliverListNewsFeedItemTitle1',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemDescription1 {
    return Intl.message(
      'Situation reports provide the latest updates on the novel coronavirus outbreak.',
      name: 'newsFeedSliverListNewsFeedItemDescription1',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemUrl1 {
    return Intl.message(
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/',
      name: 'newsFeedSliverListNewsFeedItemUrl1',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemTitle2 {
    return Intl.message(
      'Rolling Updates',
      name: 'newsFeedSliverListNewsFeedItemTitle2',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemDescription2 {
    return Intl.message(
      'Rolling updates on coronavirus disease (COVID-19) sourced from across WHO media.',
      name: 'newsFeedSliverListNewsFeedItemDescription2',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemUrl2 {
    return Intl.message(
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/events-as-they-happen',
      name: 'newsFeedSliverListNewsFeedItemUrl2',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemTitle3 {
    return Intl.message(
      'News Articles',
      name: 'newsFeedSliverListNewsFeedItemTitle3',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemDescription3 {
    return Intl.message(
      'All news releases, statements, and notes for the media.',
      name: 'newsFeedSliverListNewsFeedItemDescription3',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemUrl3 {
    return Intl.message(
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/news',
      name: 'newsFeedSliverListNewsFeedItemUrl3',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemTitle4 {
    return Intl.message(
      'Press Briefings',
      name: 'newsFeedSliverListNewsFeedItemTitle4',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemDescription4 {
    return Intl.message(
      'Coronavirus disease (COVID-19) press briefings including videos, audio and transcripts.',
      name: 'newsFeedSliverListNewsFeedItemDescription4',
      desc: '',
      args: [],
    );
  }

  String get newsFeedSliverListNewsFeedItemUrl4 {
    return Intl.message(
      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/press-briefings',
      name: 'newsFeedSliverListNewsFeedItemUrl4',
      desc: '',
      args: [],
    );
  }

  String get healthCheckTitle {
    return Intl.message(
      'Health Check',
      name: 'healthCheckTitle',
      desc: '',
      args: [],
    );
  }

  String get aboutPageTermsOfServiceLinkText {
    return Intl.message(
      'Terms of Service',
      name: 'aboutPageTermsOfServiceLinkText',
      desc: '',
      args: [],
    );
  }

  String get aboutPageTermsOfServiceLinkUrl {
    return Intl.message(
      'https://www.who.int/myhealthapp/terms-of-use',
      name: 'aboutPageTermsOfServiceLinkUrl',
      desc: '',
      args: [],
    );
  }

  String get aboutPagePrivacyPolicyLinkText {
    return Intl.message(
      'Privacy Policy',
      name: 'aboutPagePrivacyPolicyLinkText',
      desc: '',
      args: [],
    );
  }

  String get aboutPagePrivacyPolicyLinkUrl {
    return Intl.message(
      'https://www.who.int/myhealthapp/privacy-notice',
      name: 'aboutPagePrivacyPolicyLinkUrl',
      desc: '',
      args: [],
    );
  }

  String get aboutPageViewLicensesLinkText {
    return Intl.message(
      'View Licenses',
      name: 'aboutPageViewLicensesLinkText',
      desc: '',
      args: [],
    );
  }

  String aboutPageBuiltByCreditText(
      Object copyrightString, Object versionString) {
    return Intl.message(
      '$copyrightString \n\n$versionString \nBuilt by the WHO COVID-19 App Collective.',
      name: 'aboutPageBuiltByCreditText',
      desc: '',
      args: [copyrightString, versionString],
    );
  }

  String aboutPageThanksToText(Object team) {
    return Intl.message(
      'Thanks to: $team',
      name: 'aboutPageThanksToText',
      desc: '',
      args: [team],
    );
  }

  String get aboutPageTitle {
    return Intl.message(
      'About the App',
      name: 'aboutPageTitle',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageTitle {
    return Intl.message(
      'Recent Numbers',
      name: 'latestNumbersPageTitle',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageCasesDimension {
    return Intl.message(
      'Global Cases',
      name: 'latestNumbersPageCasesDimension',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageDailyToggle {
    return Intl.message(
      'New',
      name: 'latestNumbersPageDailyToggle',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageDeathsDimension {
    return Intl.message(
      'Global Deaths',
      name: 'latestNumbersPageDeathsDimension',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageGlobalCasesTitle {
    return Intl.message(
      'GLOBAL CASES',
      name: 'latestNumbersPageGlobalCasesTitle',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageGlobalDeaths {
    return Intl.message(
      'GLOBAL DEATHS',
      name: 'latestNumbersPageGlobalDeaths',
      desc: '',
      args: [],
    );
  }

  String latestNumbersPageLastUpdated(Object lastUpd) {
    return Intl.message(
      'Last updated $lastUpd',
      name: 'latestNumbersPageLastUpdated',
      desc: '',
      args: [lastUpd],
    );
  }

  String get latestNumbersPageTotalToggle {
    return Intl.message(
      'Total',
      name: 'latestNumbersPageTotalToggle',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageUpdating {
    return Intl.message(
      'Updating…',
      name: 'latestNumbersPageUpdating',
      desc: '',
      args: [],
    );
  }

  String get latestNumbersPageViewLiveData {
    return Intl.message(
      'View Live Data',
      name: 'latestNumbersPageViewLiveData',
      desc: '',
      args: [],
    );
  }

  String latestNumbersPageSourceGlobalStatsAttribution(Object attribution) {
    return Intl.message(
      'Source: $attribution',
      name: 'latestNumbersPageSourceGlobalStatsAttribution',
      desc: '',
      args: [attribution],
    );
  }

  String get notificationsEnableDialogHeader {
    return Intl.message(
      'Enable notifications',
      name: 'notificationsEnableDialogHeader',
      desc: '',
      args: [],
    );
  }

  String get notificationsEnableDialogText {
    return Intl.message(
      'As you\'ve previously disabled notifications, we\'ll need you to manually re-enable notifications via the system settings for the app',
      name: 'notificationsEnableDialogText',
      desc: '',
      args: [],
    );
  }

  String get notificationsEnableDialogOptionOpenSettings {
    return Intl.message(
      'Open Settings',
      name: 'notificationsEnableDialogOptionOpenSettings',
      desc: '',
      args: [],
    );
  }

  String get notificationsEnableDialogOptionLater {
    return Intl.message(
      'Maybe later',
      name: 'notificationsEnableDialogOptionLater',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
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
