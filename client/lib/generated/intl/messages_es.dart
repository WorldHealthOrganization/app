// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static m0(copyrightString, versionString) => "${copyrightString} ${versionString} Creada por el conjunto de aplicaciones COVID - 19 de WHO.";

  static m1(team) => "Gracias a: ${team}";

  static m2(projectIdShort) => "Sin privacidad en server - ${projectIdShort}";

  static m3(version, buildNumber) => "Versión ${version} (${buildNumber})";

  static m4(year) => "© ${year} Quién";

  static m5(country) => "${country} Total de casos";

  static m6(lastUpd) => "Última actualización ${lastUpd}";

  static m7(attribution) => "Fuente: ${attribution}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "LegalLandingPageTermsOfServiceLinkText" : MessageLookupByLibrary.simpleMessage("Condiciones de servicio"),
    "aboutPageBuiltByCreditText" : m0,
    "aboutPagePrivacyPolicyLinkText" : MessageLookupByLibrary.simpleMessage("Política de privacidad"),
    "aboutPagePrivacyPolicyLinkUrl" : MessageLookupByLibrary.simpleMessage("https://www.who.int/myhealthapp/privacy-notice"),
    "aboutPageTermsOfServiceLinkText" : MessageLookupByLibrary.simpleMessage("Condiciones de servicio"),
    "aboutPageTermsOfServiceLinkUrl" : MessageLookupByLibrary.simpleMessage("https://www.who.int/myhealthapp/terms-of-use"),
    "aboutPageThanksToText" : m1,
    "aboutPageTitle" : MessageLookupByLibrary.simpleMessage("Acerca de la aplicación"),
    "aboutPageViewLicensesLinkText" : MessageLookupByLibrary.simpleMessage("Ver licencias"),
    "checkUpIntroPageByUsingThisToolYouAgreeToItsTermsAnd" : MessageLookupByLibrary.simpleMessage("Al utilizar esta herramienta, acepta sus términos y que NO será responsable de ningún daño relacionado con su uso."),
    "checkUpIntroPageCheckup" : MessageLookupByLibrary.simpleMessage("Comprobación"),
    "checkUpIntroPageGetStarted" : MessageLookupByLibrary.simpleMessage("Empezar"),
    "checkUpIntroPageNotMedicalAdvise" : MessageLookupByLibrary.simpleMessage("La información proporcionada por esta herramienta no constituye un consejo médico y no debe utilizarse para diagnosticar o tratar enfermedades médicas."),
    "checkUpIntroPageSeeTerms" : MessageLookupByLibrary.simpleMessage("Ver términos y condiciones"),
    "checkUpIntroPageYouShouldKnow" : MessageLookupByLibrary.simpleMessage("Deberías saberlo..."),
    "checkUpIntroPageYourAnswersWillNotBeSharedWithWhoOrOthers" : MessageLookupByLibrary.simpleMessage("Sus respuestas no se compartirán con QUIÉN ni con otros sin su permiso."),
    "commonContentLoadingDialogUpdateRequiredBodyText" : MessageLookupByLibrary.simpleMessage("Actualice a la última versión de la aplicación para recibir la información y las actualizaciones más recientes."),
    "commonContentLoadingDialogUpdateRequiredDetails" : MessageLookupByLibrary.simpleMessage("Esta información puede estar obsoleta. Debes actualizar esta aplicación para recibir información más reciente de COVID - 19."),
    "commonContentLoadingDialogUpdateRequiredTitle" : MessageLookupByLibrary.simpleMessage("Se requiere actualización de la aplicación"),
    "commonContentNoPrivacyOnServer" : m2,
    "commonDialogButtonNext" : MessageLookupByLibrary.simpleMessage("Siguiente"),
    "commonDialogButtonOk" : MessageLookupByLibrary.simpleMessage("CORRECTO"),
    "commonPermissionRequestPageButtonSkip" : MessageLookupByLibrary.simpleMessage("Saltar"),
    "commonWhoAppShareIconButtonDescription" : MessageLookupByLibrary.simpleMessage("Consulte la aplicación oficial COVID-19 de la Organización Mundial de la Salud https://covid19app.who.int/app"),
    "commonWorldHealthOrganization" : MessageLookupByLibrary.simpleMessage("Organización Mundial de la salud"),
    "commonWorldHealthOrganizationCoronavirusApp" : MessageLookupByLibrary.simpleMessage("COVID-19"),
    "commonWorldHealthOrganizationCoronavirusAppVersion" : m3,
    "commonWorldHealthOrganizationCoronavirusCopyright" : m4,
    "countrySelectCountryLabel" : MessageLookupByLibrary.simpleMessage("País"),
    "countrySelectPlaceholder" : MessageLookupByLibrary.simpleMessage("Seleccione"),
    "healthCheckTitle" : MessageLookupByLibrary.simpleMessage("Control de salud"),
    "homePageCountryTotalCases" : m5,
    "homePageCovid19Response" : MessageLookupByLibrary.simpleMessage("Respuesta COVID-19"),
    "homePageGlobalTotalCases" : MessageLookupByLibrary.simpleMessage("Total de casos globales"),
    "homePagePageButtonLatestNumbers" : MessageLookupByLibrary.simpleMessage("Cifras más recientes"),
    "homePagePageButtonLatestNumbersUrl" : MessageLookupByLibrary.simpleMessage("https://who.sprinklr.com"),
    "homePagePageButtonNewsAndPress" : MessageLookupByLibrary.simpleMessage("Noticias y prensa"),
    "homePagePageButtonProtectYourself" : MessageLookupByLibrary.simpleMessage("Protéjase a sí mismo"),
    "homePagePageButtonQuestions" : MessageLookupByLibrary.simpleMessage("Preguntas y respuestas"),
    "homePagePageButtonTravelAdvice" : MessageLookupByLibrary.simpleMessage("Consejo de viaje"),
    "homePagePageButtonWHOMythBusters" : MessageLookupByLibrary.simpleMessage("Conozca los hechos"),
    "homePagePageButtonWHOMythBustersDescription" : MessageLookupByLibrary.simpleMessage("Conozca los hechos sobre el cóvid-19 y cómo evitar la propagación"),
    "homePagePageButtonYourQuestionsAnswered" : MessageLookupByLibrary.simpleMessage("Preguntas y respuestas"),
    "homePagePageDonate" : MessageLookupByLibrary.simpleMessage("Dona aquí"),
    "homePagePageDonateUrl" : MessageLookupByLibrary.simpleMessage("https://covid19responsefund.org/"),
    "homePagePageSliverListAboutTheApp" : MessageLookupByLibrary.simpleMessage("Acerca de la aplicación"),
    "homePagePageSliverListAboutTheAppDialog" : MessageLookupByLibrary.simpleMessage("La aplicación oficial COVID-19 de la Organización Mundial de la salud."),
    "homePagePageSliverListProvideFeedback" : MessageLookupByLibrary.simpleMessage("Proporcionar comentarios de la aplicación"),
    "homePagePageSliverListSettings" : MessageLookupByLibrary.simpleMessage("Ajustes"),
    "homePagePageSliverListSettingsDataCollection" : MessageLookupByLibrary.simpleMessage("Permitir que la OMS recopile análisis para mejorar el producto utilizando Google analytics"),
    "homePagePageSliverListSettingsHeader1" : MessageLookupByLibrary.simpleMessage("Análisis"),
    "homePagePageSliverListSettingsHeader2" : MessageLookupByLibrary.simpleMessage("Idioma"),
    "homePagePageSliverListSettingsNotificationsHeader" : MessageLookupByLibrary.simpleMessage("Notificaciones"),
    "homePagePageSliverListSettingsNotificationsInfo" : MessageLookupByLibrary.simpleMessage("Permitir que le envíen notificaciones para informarle de las actualizaciones"),
    "homePagePageSliverListShareTheApp" : MessageLookupByLibrary.simpleMessage("Compartir la aplicación"),
    "homePagePageSubTitle" : MessageLookupByLibrary.simpleMessage("Información y herramientas"),
    "homePagePageSupport" : MessageLookupByLibrary.simpleMessage("Ayudar a apoyar el esfuerzo de socorro"),
    "homePagePageTitle" : MessageLookupByLibrary.simpleMessage("COVID-19"),
    "latestNumbersPageCasesDimension" : MessageLookupByLibrary.simpleMessage("Casos globales"),
    "latestNumbersPageDaily" : MessageLookupByLibrary.simpleMessage("Diariamente"),
    "latestNumbersPageDailyToggle" : MessageLookupByLibrary.simpleMessage("Nuevo"),
    "latestNumbersPageDeathsDimension" : MessageLookupByLibrary.simpleMessage("Muertes globales"),
    "latestNumbersPageDisclosure" : MessageLookupByLibrary.simpleMessage("Los datos pueden estar incompletos para el día o la semana en curso."),
    "latestNumbersPageGlobalCasesTitle" : MessageLookupByLibrary.simpleMessage("CASOS GLOBALES"),
    "latestNumbersPageGlobalDeaths" : MessageLookupByLibrary.simpleMessage("MUERTES GLOBALES"),
    "latestNumbersPageLastUpdated" : m6,
    "latestNumbersPageSourceGlobalStatsAttribution" : m7,
    "latestNumbersPageTitle" : MessageLookupByLibrary.simpleMessage("Cifras recientes"),
    "latestNumbersPageTotalToggle" : MessageLookupByLibrary.simpleMessage("Total"),
    "latestNumbersPageUpdating" : MessageLookupByLibrary.simpleMessage("Actualizando…"),
    "latestNumbersPageViewLiveData" : MessageLookupByLibrary.simpleMessage("Ver datos en vivo"),
    "legalLandingPageAnd" : MessageLookupByLibrary.simpleMessage("y"),
    "legalLandingPageButtonAgree" : MessageLookupByLibrary.simpleMessage("Al continuar, acepta nuestro"),
    "legalLandingPageButtonGetStarted" : MessageLookupByLibrary.simpleMessage("Empezar"),
    "legalLandingPagePrivacyPolicyLinkText" : MessageLookupByLibrary.simpleMessage("Política de privacidad"),
    "legalLandingPagePrivacyPolicyLinkUrl" : MessageLookupByLibrary.simpleMessage("https://www.who.int/myhealthapp/privacy-notice"),
    "legalLandingPageTermsOfServiceLinkUrl" : MessageLookupByLibrary.simpleMessage("https://www.who.int/myhealthapp/terms-of-use"),
    "legalLandingPageTitle" : MessageLookupByLibrary.simpleMessage("Aplicación de información oficial WHO COVID-19"),
    "locationSharingPageButton" : MessageLookupByLibrary.simpleMessage("Permitir compartir ubicación"),
    "locationSharingPageDescription" : MessageLookupByLibrary.simpleMessage("Para obtener noticias e información locales, seleccione su país de origen."),
    "locationSharingPageTitle" : MessageLookupByLibrary.simpleMessage("Reciba las últimas noticias de su comunidad"),
    "newsFeedSliverListNewsFeedItemDescription1" : MessageLookupByLibrary.simpleMessage("Los informes de situación proporcionan las últimas actualizaciones sobre el nuevo brote coronavirus."),
    "newsFeedSliverListNewsFeedItemDescription2" : MessageLookupByLibrary.simpleMessage("Actualizaciones continuas sobre la enfermedad coronavirus (COVID-19) procedentes de los medios de comunicación de la OMS."),
    "newsFeedSliverListNewsFeedItemDescription3" : MessageLookupByLibrary.simpleMessage("Todos los comunicados de prensa, declaraciones y notas para los medios de comunicación."),
    "newsFeedSliverListNewsFeedItemDescription4" : MessageLookupByLibrary.simpleMessage("Sesiones informativas para la prensa sobre la enfermedad de Coronavirus (COVID-19), que incluyen vídeos, audio y transcripciones."),
    "newsFeedSliverListNewsFeedItemTitle1" : MessageLookupByLibrary.simpleMessage("Informes de situación"),
    "newsFeedSliverListNewsFeedItemTitle2" : MessageLookupByLibrary.simpleMessage("Actualizaciones móviles"),
    "newsFeedSliverListNewsFeedItemTitle3" : MessageLookupByLibrary.simpleMessage("Artículos de noticias"),
    "newsFeedSliverListNewsFeedItemTitle4" : MessageLookupByLibrary.simpleMessage("Reuniones informativas para la prensa"),
    "newsFeedSliverListNewsFeedItemUrl1" : MessageLookupByLibrary.simpleMessage("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/"),
    "newsFeedSliverListNewsFeedItemUrl2" : MessageLookupByLibrary.simpleMessage("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/events-as-they-happen"),
    "newsFeedSliverListNewsFeedItemUrl3" : MessageLookupByLibrary.simpleMessage("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/news"),
    "newsFeedSliverListNewsFeedItemUrl4" : MessageLookupByLibrary.simpleMessage("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/press-briefings"),
    "newsFeedTitle" : MessageLookupByLibrary.simpleMessage("Noticias y prensa"),
    "notificationsEnableDialogHeader" : MessageLookupByLibrary.simpleMessage("Habilitar notificaciones"),
    "notificationsEnableDialogOptionLater" : MessageLookupByLibrary.simpleMessage("Quizás más tarde"),
    "notificationsEnableDialogOptionOpenSettings" : MessageLookupByLibrary.simpleMessage("Configuración abierta"),
    "notificationsEnableDialogText" : MessageLookupByLibrary.simpleMessage("Como has deshabilitado notificaciones anteriormente, necesitarás volver a habilitar las notificaciones manualmente a través de la configuración del sistema para la aplicación"),
    "notificationsPagePermissionRequestPageButton" : MessageLookupByLibrary.simpleMessage("Permitir notificaciones"),
    "notificationsPagePermissionRequestPageDescription" : MessageLookupByLibrary.simpleMessage("Para estar al día con las noticias de COVID-19, active las notificaciones de aplicaciones de la Organización Mundial de la salud."),
    "notificationsPagePermissionRequestPageTitle" : MessageLookupByLibrary.simpleMessage("Manténgase al día en el CÓVID-19"),
    "protectYourselfHeader" : MessageLookupByLibrary.simpleMessage("Recomendaciones generales"),
    "protectYourselfListOfItemsPageListItem1" : MessageLookupByLibrary.simpleMessage("*lave las manos* con agua y jabón para evitar enfermar y propagar infecciones a los demás"),
    "protectYourselfListOfItemsPageListItem2" : MessageLookupByLibrary.simpleMessage("*Evita tocar* tus ojos, boca y nariz"),
    "protectYourselfListOfItemsPageListItem3" : MessageLookupByLibrary.simpleMessage("*cubre la boca y la nariz* con el codo o tejido doblado cuando tos o te escondes"),
    "protectYourselfListOfItemsPageListItem4" : MessageLookupByLibrary.simpleMessage("*permanezca a más de* 1 metro (>3 pies) de una persona enferma"),
    "protectYourselfListOfItemsPageListItem5" : MessageLookupByLibrary.simpleMessage("Solo use una máscara si usted o alguien al que cuida está enfermo con síntomas COVID-19 (especialmente tos)"),
    "protectYourselfTitle" : MessageLookupByLibrary.simpleMessage("Protéjase a sí mismo"),
    "travelAdviceContainerText" : MessageLookupByLibrary.simpleMessage("<p>La OMS sigue aconsejando <b>que no se apliquen restricciones </b> de viaje o comercio a los PAÍSES que sufren brotes de cóvidos - 19.</p> <p><b>es prudente que los viajeros que están enfermos retrasen o eviten viajar a las </b> zonas afectadas, en particular a los viajeros mayores y a las personas con enfermedades crónicas o condiciones de salud subyacentes. Las “zonas afectadas” se consideran los países, provincias, territorios o ciudades que están siendo objeto de una transmisión continua del CÓVID-19, en virtud de un contrato, a zonas que sólo informan de casos importados.</p>"),
    "travelAdvicePageButtonGeneralRecommendations" : MessageLookupByLibrary.simpleMessage("Recomendaciones generales"),
    "travelAdvicePageButtonGeneralRecommendationsDescription" : MessageLookupByLibrary.simpleMessage("Conozca los hechos sobre el cóvid-19 y cómo evitar la propagación"),
    "travelAdvicePageButtonGeneralRecommendationsLink" : MessageLookupByLibrary.simpleMessage("https://www.who.int/emergencies/diseases/novel-coronavirus-2019"),
    "travelAdvicePageListItem1Text" : MessageLookupByLibrary.simpleMessage("Automonitoree los síntomas durante 14 días y siga los protocolos nacionales de los países receptores."),
    "travelAdvicePageListItem2Text" : MessageLookupByLibrary.simpleMessage("Es posible que algunos países exijan que los viajeros que regresan entren en cuarentena."),
    "travelAdvicePageListItem3Text" : MessageLookupByLibrary.simpleMessage("Si se producen síntomas, se aconseja a los viajeros que se pongan en contacto con los proveedores de atención médica locales, preferiblemente por teléfono, y que les informen de sus síntomas y de su historial de viajes."),
    "travelAdvicePageListTitle" : MessageLookupByLibrary.simpleMessage("Los viajeros que regresen de las zonas afectadas deberán:"),
    "whoMythBustersListOfItemsPageListItem1" : MessageLookupByLibrary.simpleMessage("Hay mucha información falsa en torno a. Estos son los hechos"),
    "whoMythBustersListOfItemsPageListItem10" : MessageLookupByLibrary.simpleMessage("Los lectores térmicos PUEDEN detectar si la gente tiene fiebre pero no pueden detectar si alguien tiene coronavirus o no"),
    "whoMythBustersListOfItemsPageListItem11" : MessageLookupByLibrary.simpleMessage("Rociar alcohol o cloro por todo el cuerpo NO MATARÁ virus que ya hayan entrado en el cuerpo"),
    "whoMythBustersListOfItemsPageListItem12" : MessageLookupByLibrary.simpleMessage("Las vacunas contra la neumonía, como la vacuna neumocócica y la vacuna contra la Haemophilus influenzae tipo b (Hib), NO ofrecen protección contra los coronavirus."),
    "whoMythBustersListOfItemsPageListItem13" : MessageLookupByLibrary.simpleMessage("NO hay pruebas de que el enjuague regular de la nariz con solución salina haya protegido a las personas de la infección con los coronavirus"),
    "whoMythBustersListOfItemsPageListItem14" : MessageLookupByLibrary.simpleMessage("El ajo es saludable, pero NO hay pruebas del brote actual de que comer ajo haya protegido a la gente de los coronavirus"),
    "whoMythBustersListOfItemsPageListItem15" : MessageLookupByLibrary.simpleMessage("Los antibióticos NO trabajan contra los virus, los antibióticos solo lo hacen contra las bacterias"),
    "whoMythBustersListOfItemsPageListItem16" : MessageLookupByLibrary.simpleMessage("Hasta la fecha, NO se recomienda ningún medicamento específico para prevenir o tratar los coronavirus"),
    "whoMythBustersListOfItemsPageListItem2" : MessageLookupByLibrary.simpleMessage("Las personas de todas las edades PUEDEN ser infectadas por los coronavirus. Las personas mayores, y las personas con afecciones médicas preexistentes (como el asma, la diabetes, las enfermedades cardíacas) parecen ser más vulnerables a contraer una enfermedad grave con el virus."),
    "whoMythBustersListOfItemsPageListItem3" : MessageLookupByLibrary.simpleMessage("El frío y la nieve no pueden matar a los coronavirus"),
    "whoMythBustersListOfItemsPageListItem4" : MessageLookupByLibrary.simpleMessage("Los coronavirus SE PUEDEN transmitir en zonas con climas cálidos y húmedos"),
    "whoMythBustersListOfItemsPageListItem5" : MessageLookupByLibrary.simpleMessage("Los coronavirus no se pueden transmitir a través de los mosquitos"),
    "whoMythBustersListOfItemsPageListItem6" : MessageLookupByLibrary.simpleMessage("NO hay pruebas de que los animales/mascotas acompañantes, como perros o gatos, puedan transmitir los coronavirus"),
    "whoMythBustersListOfItemsPageListItem7" : MessageLookupByLibrary.simpleMessage("Tomar un baño caliente NO evita los coronavirus"),
    "whoMythBustersListOfItemsPageListItem8" : MessageLookupByLibrary.simpleMessage("Los secadores de mano NO son eficaces para matar a los coronavirus"),
    "whoMythBustersListOfItemsPageListItem9" : MessageLookupByLibrary.simpleMessage("La luz ultravioleta no DEBE utilizarse para esterilización y puede provocar irritación cutánea")
  };
}
