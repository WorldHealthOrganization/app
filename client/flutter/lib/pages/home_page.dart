import 'package:WHOFlutter/api/question_data.dart';
import 'package:WHOFlutter/components/arrow_button.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/main.dart';
import 'package:WHOFlutter/pages/about_page.dart';
import 'package:WHOFlutter/pages/latest_numbers.dart';
import 'package:WHOFlutter/pages/news_feed.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/question_index.dart';
import 'package:WHOFlutter/pages/settings_page.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:animations/animations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  HomePage(this.analytics);

  _logAnalyticsEvent(String name) async {
    await analytics.logEvent(name: name);
  }

  @override
  Widget build(BuildContext context) {
    final String versionString = packageInfo != null
        ? '${S.of(context).commonWorldHealthOrganizationCoronavirusAppVersion(packageInfo.version, packageInfo.buildNumber)}\n'
        : null;

    final String copyrightString = S
        .of(context)
        .commonWorldHealthOrganizationCoronavirusCopyright(DateTime.now().year);

    final divider = Container(height: 1, color: Color(0xffC9CDD6));

    return PageScaffold(context,
        title: S.of(context).homePagePageTitle,
        subtitle: S.of(context).homePagePageSubTitle,
        showBackButton: false,
        showLogoInHeader: true,
        body: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              _MenuGrid(logAnalyticsEvent: _logAnalyticsEvent),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Text(
                  S.of(context).homePagePageSliverListSupport,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffCA6B35)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: ArrowButton(
                    title: S.of(context).homePagePageSliverListDonate,
                    color: Color(0xffCA6B35),
                    onPressed: () {
                      _logAnalyticsEvent('Donate');
                      launch(S.of(context).homePagePageSliverListDonateUrl);
                    },
                  )),
              divider,
              Material(
                color: Colors.white,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.share, color: Color(0xffCA6B35)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            S.of(context).homePagePageSliverListShareTheApp,
                            style: TextStyle(
                              color: Color(0xffCA6B35),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFC9CDD6),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    analytics.logShare(
                        contentType: 'App',
                        itemId: null,
                        method: 'Website link');
                    Share.share(
                        S.of(context).commonWhoAppShareIconButtonDescription);
                  },
                ),
              ),
              divider,
              Material(
                color: Colors.white,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.settings, color: Color(0xffCA6B35)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            S.of(context).homePagePageSliverListSettings,
                            style: TextStyle(
                              color: Color(0xffCA6B35),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFC9CDD6),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _logAnalyticsEvent('Settings');
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => SettingsPage()),
                    );
                  },
                ),
              ),
              divider,
              Material(
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    S.of(context).homePagePageSliverListAboutTheApp,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFC9CDD6),
                  ),
                  onTap: () {
                    _logAnalyticsEvent('About');
                    return Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => AboutPage()));
                  },
                ),
              ),
              divider,
              Container(
                height: 25,
              ),
              Text(
                '${versionString ?? ''}$copyrightString',
                style: TextStyle(color: Color(0xff26354E).withOpacity(0.75)),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 40,
              ),
            ]),
          )
        ]);
  }
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid({Key key, @required this.logAnalyticsEvent})
      : assert(logAnalyticsEvent != null),
        super(key: key);

  final Function(String) logAnalyticsEvent;

  final TextStyle largeTitleStyle = const TextStyle(
    fontWeight: FontWeight.w700,
  );

  final TextStyle mediumTitleStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 11.2,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _MenuButton(
                    onTap: () => logAnalyticsEvent('ProtectYourself'),
                    page: ProtectYourself(),
                    scaleFactor: 2,
                    color: Color(0xff008DC9),
                    title: S.of(context).homePagePageButtonProtectYourself,
                    mainAxisAlignment: MainAxisAlignment.end,
                    titleStyle: largeTitleStyle,
                  ),
                ),
                _HorizontalSpacer(),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      IntrinsicHeight(
                        child: _MenuButton(
                          onTap: () => logAnalyticsEvent('LatestNumbers'),
                          page: LatestNumbers(),
                          color: Color(0xff1A458E),
                          title: S.of(context).homePagePageButtonLatestNumbers,
                          titleStyle: mediumTitleStyle,
                        ),
                      ),
                      _VerticalSpacer(),
                      IntrinsicHeight(
                        child: _MenuButton(
                          onTap: () => logAnalyticsEvent('QuestionsAnswered'),
                          page: QuestionIndexPage(
                            dataSource: QuestionData.yourQuestionsAnswered,
                            title: S.of(context).homePagePageButtonQuestions,
                          ),
                          color: Color(0xff3DA7D4),
                          title: S
                              .of(context)
                              .homePagePageButtonYourQuestionsAnswered,
                          titleStyle: mediumTitleStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _VerticalSpacer(),
          _MenuButton(
            onTap: () => logAnalyticsEvent('GetTheFacts'),
            page: QuestionIndexPage(
              dataSource: QuestionData.whoMythbusters,
              title: S.of(context).homePagePageButtonWHOMythBusters,
            ),
            color: Color(0xff234689),
            title: S.of(context).homePagePageButtonWHOMythBusters,
            description:
                S.of(context).homePagePageButtonWHOMythBustersDescription,
            mainAxisAlignment: MainAxisAlignment.center,
            titleStyle: largeTitleStyle,
          ),
          _VerticalSpacer(),
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _MenuButton(
                    onTap: () => logAnalyticsEvent('TravelAdvice'),
                    page: TravelAdvice(),
                    color: Color(0xff3DA7D4),
                    title: S.of(context).homePagePageButtonTravelAdvice,
                    titleStyle: mediumTitleStyle,
                  ),
                ),
                _HorizontalSpacer(),
                Expanded(
                  child: _MenuButton(
                    onTap: () => logAnalyticsEvent('News'),
                    page: NewsFeed(),
                    color: Color(0xff008DC9),
                    title: S.of(context).homePagePageButtonNewsAndPress,
                    titleStyle: mediumTitleStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  static const tileDefaultAspectRatio = (1 / 0.73);
  final double scaleFactor;
  final Color color;
  final String title;
  final String description;
  final Widget page;
  // TODO Not needed after analytics automatically logs route changes
  final VoidCallback onTap;
  final TextStyle titleStyle;
  final MainAxisAlignment mainAxisAlignment;

  const _MenuButton({
    Key key,
    @required this.page,
    @required this.color,
    @required this.title,
    @required this.onTap,
    this.scaleFactor = 1,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.w700),
    this.description,
    this.mainAxisAlignment = MainAxisAlignment.start,
  })  : assert(scaleFactor != null),
        assert(page != null),
        assert(title != null),
        assert(titleStyle != null),
        assert(mainAxisAlignment != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final minHeight = (MediaQuery.of(context).size.width / 2) *
        (1 / tileDefaultAspectRatio) *
        scaleFactor;

    return OpenContainer(
      tappable: false,
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      closedColor: color,
      openBuilder: (BuildContext context, VoidCallback close) {
        return page;
      },
      closedBuilder: (BuildContext context, VoidCallback open) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: PageButton(
            color,
            title,
            () {
              open();
              onTap();
            },
            titleStyle: titleStyle,
            description: description ?? '',
            mainAxisAlignment: mainAxisAlignment,
            borderRadius: 16,
          ),
        );
      },
    );
  }
}

class _HorizontalSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox(width: 16);
}

class _VerticalSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox(height: 16);
}
