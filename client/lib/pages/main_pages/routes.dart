import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/api/user_preferences_store.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/pages/about_page.dart';
import 'package:who_app/pages/facts_carousel_page.dart';
import 'package:who_app/pages/main_pages/app_tab_router.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/news_page.dart';
import 'package:who_app/pages/onboarding/onboarding_page.dart';
import 'package:who_app/pages/protect_yourself.dart';
import 'package:who_app/pages/question_index.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_results_page.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_view.dart';
import 'package:who_app/pages/travel_advice.dart';

import 'check_up/check_up_page.dart';

class Routes {
  static final Map<String, WidgetBuilder> map = {
    '/home': (context) => AppTabRouter(
          dataSource: Provider.of<ContentStore>(context),
          tabs: AppTabRouter.defaultTabs,
          navItems: AppTabRouter.defaultNavItems,
        ),
    '/about': (context) => AboutPage(),
    '/onboarding': (context) => OnboardingPage(
          service: Provider.of<WhoService>(context),
          prefs: Provider.of<UserPreferencesStore>(context),
        ),
    '/travel-advice': (context) => TravelAdvice(
          dataSource: Provider.of<ContentStore>(context),
        ),
    '/protect-yourself': (context) => ProtectYourself(
          dataSource: Provider.of<ContentStore>(context),
        ),
    '/qa': (context) => QuestionIndexPage(
          dataSource: Provider.of<ContentStore>(context),
          title: S.of(context).homePagePageButtonQuestions,
        ),
    '/check-up': (context) => CheckUpPage(
          dataSource: Provider.of<ContentStore>(context),
        ),
    '/symptom-checker-survey': (context) => SymptomCheckerView(
          dataSource: Provider.of<ContentStore>(context),
        ),
    '/symptom-checker-results': (context) => SymptomCheckerResultsPage(
        model:
            ModalRoute.of(context).settings.arguments as SymptomCheckerModel),
    '/news': (context) => NewsIndexPage(
          dataSource: Provider.of<ContentStore>(context),
        ),
    '/get-the-facts': (context) => GetTheFactsPage(
          dataSource: Provider.of<ContentStore>(context),
          title: S.of(context).homePagePageButtonWHOMythBusters,
        ),
    '/recent-numbers': (context) =>
        RecentNumbersPage(statsStore: Provider.of<StatsStore>(context)),
  };
}

class HeroTags {
  static const settings = 'heroTag_settings';
  static const learn = 'heroTag_learn';
  static const checkUp = 'heroTag_checkUp';
  static const stats = 'heroTag_stats';
}
