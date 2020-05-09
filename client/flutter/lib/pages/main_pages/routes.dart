import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/advice_content.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/api/content/schema/question_content.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/pages/about_page.dart';
import 'package:who_app/pages/facts_carousel_page.dart';
import 'package:who_app/pages/main_pages/app_tab_router.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/pages/news_feed.dart';
import 'package:who_app/pages/onboarding/onboarding_page.dart';
import 'package:who_app/pages/protect_yourself.dart';
import 'package:who_app/pages/question_index.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_view.dart';
import 'package:who_app/pages/travel_advice.dart';

class Routes {
  static final Map<String, WidgetBuilder> map = {
    '/home': (context) =>
        AppTabRouter(AppTabRouter.defaultTabs, AppTabRouter.defaultNavItems),
    '/about': (context) => AboutPage(),
    '/onboarding': (context) => OnboardingPage(),
    '/travel-advice': (context) => TravelAdvice(
          dataSource: AdviceContent.travelAdvice,
        ),
    '/protect-yourself': (context) => ProtectYourself(
          dataSource: FactContent.protectYourself,
        ),
    '/qa': (context) => QuestionIndexPage(
          dataSource: QuestionContent.yourQuestionsAnswered,
          title: S.of(context).homePagePageButtonQuestions,
        ),
    '/symptom-checker': (context) => SymptomCheckerView(),
    '/news': (context) => NewsFeed(),
    '/get-the-facts': (context) => FactsCarouselPage(
          dataSource: FactContent.getTheFacts,
          title: S.of(context).homePagePageButtonWHOMythBusters,
        ),
    '/recent-numbers': (context) => RecentNumbersPage(),
  };
}

class HeroTags {
  static const settings = 'heroTag_settings';
  static const learn = 'heroTag_learn';
  static const stats = 'heroTag_stats';
}
