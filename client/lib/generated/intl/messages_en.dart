// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(copyrightString, versionString) =>
      "${copyrightString} \n\n${versionString} \nBuilt by the WHO COVID-19 App Collective.";

  static m1(team) => "Thanks to: ${team}";

  static m2(version, buildNumber) => "Version ${version} (${buildNumber})";

  static m3(year) => "© ${year} WHO";

  static m4(lastUpd) => "Last updated ${lastUpd}";

  static m5(attribution) => "Source: ${attribution}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "LegalLandingPageTermsOfServiceLinkText":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "aboutPageBuiltByCreditText": m0,
        "aboutPagePrivacyPolicyLinkText":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "aboutPageTermsOfServiceLinkText":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "aboutPageTermsOfServiceLinkUrl": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/myhealthapp/terms-of-use"),
        "aboutPageThanksToText": m1,
        "aboutPageTitle": MessageLookupByLibrary.simpleMessage("About the App"),
        "aboutPageViewLicensesLinkText":
            MessageLookupByLibrary.simpleMessage("View Licenses"),
        "aboutPagePrivacyPolicyLinkUrl": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/myhealthapp/privacy-notice"),
        "commonContentLoadingDialogUpdateRequiredBodyText":
            MessageLookupByLibrary.simpleMessage(
                "Please update to the latest version of the app in order to receive the latest information and updates."),
        "commonContentLoadingDialogUpdateRequiredTitle":
            MessageLookupByLibrary.simpleMessage("App Update Required"),
        "commonDialogButtonOk": MessageLookupByLibrary.simpleMessage("OK"),
        "commonPermissionRequestPageButtonSkip":
            MessageLookupByLibrary.simpleMessage("Skip"),
        "commonWhoAppShareIconButtonDescription":
            MessageLookupByLibrary.simpleMessage(
                "Check out the official COVID-19 app from the World Health Organization https://whoapp.org/app"),
        "commonWorldHealthOrganization":
            MessageLookupByLibrary.simpleMessage("World Health Organization"),
        "commonWorldHealthOrganizationCoronavirusApp":
            MessageLookupByLibrary.simpleMessage("COVID-19"),
        "commonWorldHealthOrganizationCoronavirusAppVersion": m2,
        "commonWorldHealthOrganizationCoronavirusCopyright": m3,
        "healthCheckTitle":
            MessageLookupByLibrary.simpleMessage("Health Check"),
        "homePagePageButtonLatestNumbers":
            MessageLookupByLibrary.simpleMessage("Latest Numbers"),
        "homePagePageButtonLatestNumbersUrl":
            MessageLookupByLibrary.simpleMessage("https://who.sprinklr.com"),
        "homePagePageButtonNewsAndPress":
            MessageLookupByLibrary.simpleMessage("News & Press"),
        "homePagePageButtonProtectYourself":
            MessageLookupByLibrary.simpleMessage("Protect Yourself"),
        "homePagePageButtonQuestions":
            MessageLookupByLibrary.simpleMessage("Questions & Answers"),
        "homePagePageButtonTravelAdvice":
            MessageLookupByLibrary.simpleMessage("Travel Advice"),
        "homePagePageButtonWHOMythBusters":
            MessageLookupByLibrary.simpleMessage("Get the Facts"),
        "homePagePageButtonWHOMythBustersDescription":
            MessageLookupByLibrary.simpleMessage(
                "Learn the facts about COVID-19 and how to prevent the spread"),
        "homePagePageButtonYourQuestionsAnswered":
            MessageLookupByLibrary.simpleMessage("Questions & Answers"),
        "homePagePageSliverListAboutTheApp":
            MessageLookupByLibrary.simpleMessage("About the app"),
        "homePagePageSliverListAboutTheAppDialog":
            MessageLookupByLibrary.simpleMessage(
                "The official World Health Organization COVID-19 App."),
        "homePagePageSliverListDonate":
            MessageLookupByLibrary.simpleMessage("Donate Here"),
        "homePagePageSliverListDonateUrl": MessageLookupByLibrary.simpleMessage(
            "https://covid19responsefund.org/"),
        "homePagePageSliverListProvideFeedback":
            MessageLookupByLibrary.simpleMessage("Provide App Feedback"),
        "homePagePageSliverListSettings":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "homePagePageSliverListSettingsDataCollection":
            MessageLookupByLibrary.simpleMessage(
                "Allow WHO to collect analytics for product improvement using Google Analytics"),
        "homePagePageSliverListSettingsHeader1":
            MessageLookupByLibrary.simpleMessage("Analytics"),
        "homePagePageSliverListSettingsHeader2":
            MessageLookupByLibrary.simpleMessage("Language"),
        "homePagePageSliverListSettingsNotificationsHeader":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "homePagePageSliverListSettingsNotificationsInfo":
            MessageLookupByLibrary.simpleMessage(
                "Allow WHO to send you notifications to inform you of updates"),
        "homePagePageSliverListShareTheApp":
            MessageLookupByLibrary.simpleMessage("Share the app"),
        "homePagePageSliverListSupport": MessageLookupByLibrary.simpleMessage(
            "Help support the\nrelief effort"),
        "homePagePageSubTitle":
            MessageLookupByLibrary.simpleMessage("Information & tools"),
        "homePagePageTitle": MessageLookupByLibrary.simpleMessage("COVID-19"),
        "latestNumbersPageCasesDimension":
            MessageLookupByLibrary.simpleMessage("Global Cases"),
        "latestNumbersPageDailyToggle":
            MessageLookupByLibrary.simpleMessage("New"),
        "latestNumbersPageDeathsDimension":
            MessageLookupByLibrary.simpleMessage("Global Deaths"),
        "latestNumbersPageGlobalCasesTitle":
            MessageLookupByLibrary.simpleMessage("GLOBAL CASES"),
        "latestNumbersPageGlobalDeaths":
            MessageLookupByLibrary.simpleMessage("GLOBAL DEATHS"),
        "latestNumbersPageLastUpdated": m4,
        "latestNumbersPageSourceGlobalStatsAttribution": m5,
        "latestNumbersPageTitle":
            MessageLookupByLibrary.simpleMessage("Recent Numbers"),
        "latestNumbersPageTotalToggle":
            MessageLookupByLibrary.simpleMessage("Total"),
        "latestNumbersPageUpdating":
            MessageLookupByLibrary.simpleMessage("Updating…"),
        "latestNumbersPageViewLiveData":
            MessageLookupByLibrary.simpleMessage("View Live Data"),
        "legalLandingPageAnd": MessageLookupByLibrary.simpleMessage(" and "),
        "legalLandingPageButtonAgree": MessageLookupByLibrary.simpleMessage(
            "By proceeding, you agree to our\n"),
        "legalLandingPageButtonGetStarted":
            MessageLookupByLibrary.simpleMessage("Get Started"),
        "legalLandingPagePrivacyPolicyLinkText":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "legalLandingPagePrivacyPolicyLinkUrl":
            MessageLookupByLibrary.simpleMessage(
                "https://www.who.int/myhealthapp/privacy-notice"),
        "legalLandingPageTermsOfServiceLinkUrl":
            MessageLookupByLibrary.simpleMessage(
                "https://www.who.int/myhealthapp/terms-of-use"),
        "legalLandingPageTitle": MessageLookupByLibrary.simpleMessage(
            "Official WHO COVID-19 Information App"),
        "locationSharingPageButton":
            MessageLookupByLibrary.simpleMessage("Allow Location Sharing"),
        "locationSharingPageDescription": MessageLookupByLibrary.simpleMessage(
            "To get local news and information, select your home country."),
        "locationSharingPageTitle": MessageLookupByLibrary.simpleMessage(
            "Get the latest news from your community"),
        "newsFeedSliverListNewsFeedItemDescription1":
            MessageLookupByLibrary.simpleMessage(
                "Situation reports provide the latest updates on the novel coronavirus outbreak."),
        "newsFeedSliverListNewsFeedItemDescription2":
            MessageLookupByLibrary.simpleMessage(
                "Rolling updates on coronavirus disease (COVID-19) sourced from across WHO media."),
        "newsFeedSliverListNewsFeedItemDescription3":
            MessageLookupByLibrary.simpleMessage(
                "All news releases, statements, and notes for the media."),
        "newsFeedSliverListNewsFeedItemDescription4":
            MessageLookupByLibrary.simpleMessage(
                "Coronavirus disease (COVID-19) press briefings including videos, audio and transcripts."),
        "newsFeedSliverListNewsFeedItemTitle1":
            MessageLookupByLibrary.simpleMessage("Situation Reports"),
        "newsFeedSliverListNewsFeedItemTitle2":
            MessageLookupByLibrary.simpleMessage("Rolling Updates"),
        "newsFeedSliverListNewsFeedItemTitle3":
            MessageLookupByLibrary.simpleMessage("News Articles"),
        "newsFeedSliverListNewsFeedItemTitle4":
            MessageLookupByLibrary.simpleMessage("Press Briefings"),
        "newsFeedSliverListNewsFeedItemUrl1": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/"),
        "newsFeedSliverListNewsFeedItemUrl2": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/events-as-they-happen"),
        "newsFeedSliverListNewsFeedItemUrl3": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/news"),
        "newsFeedSliverListNewsFeedItemUrl4": MessageLookupByLibrary.simpleMessage(
            "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/press-briefings"),
        "newsFeedTitle": MessageLookupByLibrary.simpleMessage("News & Press"),
        "notificationsEnableDialogHeader":
            MessageLookupByLibrary.simpleMessage("Enable notifications"),
        "notificationsEnableDialogOptionLater":
            MessageLookupByLibrary.simpleMessage("Maybe later"),
        "notificationsEnableDialogOptionOpenSettings":
            MessageLookupByLibrary.simpleMessage("Open Settings"),
        "notificationsEnableDialogText": MessageLookupByLibrary.simpleMessage(
            "As you\'ve previously disabled notifications, we\'ll need you to manually re-enable notifications via the system settings for the app"),
        "notificationsPagePermissionRequestPageButton":
            MessageLookupByLibrary.simpleMessage("Allow Notifications"),
        "notificationsPagePermissionRequestPageDescription":
            MessageLookupByLibrary.simpleMessage(
                "To stay up to date with COVID-19 news, turn on app notifications from the World Health Organization."),
        "notificationsPagePermissionRequestPageTitle":
            MessageLookupByLibrary.simpleMessage("Stay up to date on COVID-19"),
        "protectYourselfHeader":
            MessageLookupByLibrary.simpleMessage("General Recommendations"),
        "protectYourselfListOfItemsPageListItem1":
            MessageLookupByLibrary.simpleMessage(
                "*Wash your hands* with soap and water to avoid getting sick and spreading infections to others"),
        "protectYourselfListOfItemsPageListItem2":
            MessageLookupByLibrary.simpleMessage(
                "*Avoid touching* your eyes, mouth, and nose"),
        "protectYourselfListOfItemsPageListItem3":
            MessageLookupByLibrary.simpleMessage(
                "*Cover your mouth and nose* with your bent elbow or tissue when you cough or sneeze"),
        "protectYourselfListOfItemsPageListItem4":
            MessageLookupByLibrary.simpleMessage(
                "*Stay more than* 1 meter (>3 feet) away from a person who is sick"),
        "protectYourselfListOfItemsPageListItem5":
            MessageLookupByLibrary.simpleMessage(
                "Only wear a mask if you or someone you are looking after are ill with COVID-19 symptoms (especially coughing)"),
        "protectYourselfTitle":
            MessageLookupByLibrary.simpleMessage("Protect Yourself"),
        "travelAdviceContainerText": MessageLookupByLibrary.simpleMessage(
            "<p>WHO continues to <b>advise against the application of travel or trade restrictions</b> to countries experiencing COVID-19 outbreaks.</p> <p><b>It is prudent for travellers who are sick to delay or avoid travel to affected areas</b>, in particular for elderly travellers and people with chronic diseases or underlying health conditions. “Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contract to areas reporting only imported cases.</p>"),
        "travelAdvicePageButtonGeneralRecommendations":
            MessageLookupByLibrary.simpleMessage("General Recommendations"),
        "travelAdvicePageButtonGeneralRecommendationsDescription":
            MessageLookupByLibrary.simpleMessage(
                "Learn the facts about COVID-19 and how to prevent the spread"),
        "travelAdvicePageButtonGeneralRecommendationsLink":
            MessageLookupByLibrary.simpleMessage(
                "https://www.who.int/emergencies/diseases/novel-coronavirus-2019"),
        "travelAdvicePageListItem1Text": MessageLookupByLibrary.simpleMessage(
            "Self-monitor for symptoms for 14 days and follow national protocols of receiving countries."),
        "travelAdvicePageListItem2Text": MessageLookupByLibrary.simpleMessage(
            "Some countries may require returning travellers to enter quarantine."),
        "travelAdvicePageListItem3Text": MessageLookupByLibrary.simpleMessage(
            "If symptoms occur, travellers are advised to contact local health care providers, preferably by phone, and inform them of their symptoms and travel history."),
        "travelAdvicePageListTitle": MessageLookupByLibrary.simpleMessage(
            "Travellers returning from affected areas should:"),
        "whoMythBustersListOfItemsPageListItem1":
            MessageLookupByLibrary.simpleMessage(
                "There is a lot of false information around. These are the facts"),
        "whoMythBustersListOfItemsPageListItem10":
            MessageLookupByLibrary.simpleMessage(
                "Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus"),
        "whoMythBustersListOfItemsPageListItem11":
            MessageLookupByLibrary.simpleMessage(
                "Spraying alcohol or chlorine all over your body WILL NOT kill viruses that have already entered your body"),
        "whoMythBustersListOfItemsPageListItem12":
            MessageLookupByLibrary.simpleMessage(
                "Vaccines against pneumonia, such as pneumococcal vaccine and Haemophilus influenzae type b (Hib) vaccine, DO NOT provide protection against the coronavirus"),
        "whoMythBustersListOfItemsPageListItem13":
            MessageLookupByLibrary.simpleMessage(
                "There is NO evidence that regularly rinsing the nose with saline has protected people from infection with the coronavirus"),
        "whoMythBustersListOfItemsPageListItem14":
            MessageLookupByLibrary.simpleMessage(
                "Garlic is healthy but there is NO evidence from the current outbreak that eating garlic has protected people from the coronavirus"),
        "whoMythBustersListOfItemsPageListItem15":
            MessageLookupByLibrary.simpleMessage(
                "Antibiotics DO NOT work against viruses, antibiotics only work against bacteria"),
        "whoMythBustersListOfItemsPageListItem16":
            MessageLookupByLibrary.simpleMessage(
                "To date, there is NO specific medicine recommended to prevent or treat the coronavirus"),
        "whoMythBustersListOfItemsPageListItem2":
            MessageLookupByLibrary.simpleMessage(
                "People of all ages CAN be infected by the coronavirus. Older people, and people with pre-existing medical conditions (such as asthma, diabetes, heart disease) appear to be more vulnerable to becoming severely ill with the virus"),
        "whoMythBustersListOfItemsPageListItem3":
            MessageLookupByLibrary.simpleMessage(
                "Cold weather and snow CANNOT kill the coronavirus"),
        "whoMythBustersListOfItemsPageListItem4":
            MessageLookupByLibrary.simpleMessage(
                "The coronavirus CAN be transmitted in areas with hot and humid climates"),
        "whoMythBustersListOfItemsPageListItem5":
            MessageLookupByLibrary.simpleMessage(
                "The coronavirus CANNOT be transmitted through mosquito bites"),
        "whoMythBustersListOfItemsPageListItem6":
            MessageLookupByLibrary.simpleMessage(
                "There is NO evidence that companion animals/pets such as dogs or cats can transmit the coronavirus"),
        "whoMythBustersListOfItemsPageListItem7":
            MessageLookupByLibrary.simpleMessage(
                "Taking a hot bath DOES NOT prevent the coronavirus"),
        "whoMythBustersListOfItemsPageListItem8":
            MessageLookupByLibrary.simpleMessage(
                "Hand dryers are NOT effective in killing the coronavirus"),
        "whoMythBustersListOfItemsPageListItem9":
            MessageLookupByLibrary.simpleMessage(
                "Ultraviolet light SHOULD NOT be used for sterilization and can cause skin irritation")
      };
}
