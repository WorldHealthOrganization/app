import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'package:pedantic/pedantic.dart';
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

  Future<void> updateBundle<T extends ContentBase>(String name, T old,
      T Function(ContentBundle) constructor, void Function(T) setter) async {
    final newValue =
        constructor(await service.load(locale, countryIsoCode, name));
    if ((newValue?.bundle?.contentVersion ?? 0) >
        (old?.bundle?.contentVersion ?? 0)) {
      setter(newValue);
    }
  }

  @action
  @override
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
    try {
      await Future.wait([
        updateBundle<IndexContent>(
            'home_index', homeIndex, (cb) => IndexContent(cb), (v) {
          homeIndex = v;
        }),
        updateBundle<AdviceContent>(
            'travel_advice', travelAdvice, (cb) => AdviceContent(cb), (v) {
          travelAdvice = v;
        }),
        updateBundle<FactContent>(
            'get_the_facts', getTheFacts, (cb) => FactContent(cb), (v) {
          getTheFacts = v;
        }),
        updateBundle<FactContent>(
            'protect_yourself', protectYourself, (cb) => FactContent(cb), (v) {
          protectYourself = v;
        }),
        updateBundle<IndexContent>(
            'learn_index', learnIndex, (cb) => IndexContent(cb), (v) {
          learnIndex = v;
        }),
        updateBundle<IndexContent>(
            'news_index', newsIndex, (cb) => IndexContent(cb), (v) {
          newsIndex = v;
        }),
        updateBundle<QuestionContent>('your_questions_answered',
            questionsAnswered, (cb) => QuestionContent(cb), (v) {
          questionsAnswered = v;
        }),
        updateBundle<PosterContent>(
            'symptom_poster', symptomPoster, (cb) => PosterContent(cb), (v) {
          symptomPoster = v;
        })
      ]);

      unawaited(
        UserPreferences().setLastUpdatedContent(
          DateTime.now().millisecondsSinceEpoch,
        ),
      );
      print(
        'ContentStore update finished',
      );
    } catch (e) {
      unawaited(
        FirebaseCrashlytics.instance.recordFlutterError(e),
      );
      print(
        'ContentStore update failed',
      );
    }
  }
}
