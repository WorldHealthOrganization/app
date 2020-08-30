import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/api/content/content_loading.dart';
import 'package:who_app/api/content/schema/advice_content.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/content/schema/poster_content.dart';
import 'package:who_app/api/content/schema/question_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/api/updateable.dart';
import 'package:who_app/api/user_preferences.dart';

// Whenever this file is modified, regenerate the .g.dart file using the command:
// flutter packages pub run build_runner build
part 'content_store.g.dart';

class ContentStore extends _ContentStore with _$ContentStore {
  ContentStore(
      {@required ContentService service,
      @required Locale locale,
      @required String countryIsoCode})
      : super(service: service, locale: locale, countryIsoCode: countryIsoCode);
}

abstract class _ContentStore with Store implements Updateable {
  final Locale locale;
  final ContentService service;
  final String countryIsoCode;

  _ContentStore(
      {@required this.service,
      @required this.locale,
      @required this.countryIsoCode});

  bool _unsupportedSchemaVersionAvailable(ContentBase cb) =>
      cb?.bundle?.unsupportedSchemaVersionAvailable ?? false;

  @computed
  bool get unsupportedSchemaVersionAvailable => [
        travelAdvice,
        getTheFacts,
        protectYourself,
        homeIndex,
        learnIndex,
        newsIndex,
        questionsAnswered,
        symptomPoster,
      ].map(_unsupportedSchemaVersionAvailable).reduce((a, b) => a || b);

  @observable
  LogicContext logicContext;

  @observable
  AdviceContent travelAdvice;

  @observable
  FactContent getTheFacts;

  @observable
  FactContent protectYourself;

  @observable
  IndexContent homeIndex;

  @observable
  IndexContent learnIndex;

  @observable
  IndexContent newsIndex;

  @observable
  QuestionContent questionsAnswered;

  @observable
  PosterContent symptomPoster;

  @action
  Future<void> update() async {
    // TODO: UserPreferences should be injected dependency.
    if (!await UserPreferences().getTermsOfServiceCompleted()) {
      print('ContentStore update skipped');
      return;
    }
    print('ContentStore update');

    logicContext = await LogicContext.generate(isoCountryCode: countryIsoCode);

    // Note the logic enforcing that only *newer* versions replace older versions in
    // the *cache* must be enforced elsewhere.
    final travelAdvice2 = AdviceContent(
        await service.load(locale, countryIsoCode, 'travel_advice'));
    if (travelAdvice?.bundle?.contentVersion !=
        travelAdvice2?.bundle?.contentVersion) {
      travelAdvice = travelAdvice2;
    }
    final getTheFacts2 = FactContent(
        await service.load(locale, countryIsoCode, 'get_the_facts'));
    if (getTheFacts?.bundle?.contentVersion !=
        getTheFacts2?.bundle?.contentVersion) {
      getTheFacts = getTheFacts2;
    }
    final protectYourself2 = FactContent(
        await service.load(locale, countryIsoCode, 'protect_yourself'));
    if (protectYourself?.bundle?.contentVersion !=
        protectYourself2?.bundle?.contentVersion) {
      protectYourself = protectYourself2;
    }
    final homeIndex2 =
        IndexContent(await service.load(locale, countryIsoCode, 'home_index'));
    if (homeIndex?.bundle?.contentVersion !=
        homeIndex2?.bundle?.contentVersion) {
      homeIndex = homeIndex2;
    }
    final learnIndex2 =
        IndexContent(await service.load(locale, countryIsoCode, 'learn_index'));
    if (learnIndex?.bundle?.contentVersion !=
        learnIndex2?.bundle?.contentVersion) {
      learnIndex = learnIndex2;
    }
    final newsIndex2 =
        IndexContent(await service.load(locale, countryIsoCode, 'news_index'));
    if (newsIndex?.bundle?.contentVersion !=
        newsIndex2?.bundle?.contentVersion) {
      newsIndex = newsIndex2;
    }
    final questionsAnswered2 = QuestionContent(
        await service.load(locale, countryIsoCode, 'your_questions_answered'));
    if (questionsAnswered?.bundle?.contentVersion !=
        questionsAnswered2?.bundle?.contentVersion) {
      questionsAnswered = questionsAnswered2;
    }
    final symptomPoster2 = PosterContent(
        await service.load(locale, countryIsoCode, 'symptom_poster'));
    if (symptomPoster?.bundle?.contentVersion !=
        symptomPoster2?.bundle?.contentVersion) {
      symptomPoster = symptomPoster2;
    }
  }
}
