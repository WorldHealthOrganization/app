import 'package:WHOFlutter/api/question_data.dart';
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
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    double tileHeightFactor = 0.73;
    final String versionString = packageInfo != null
        ? '${S.of(context).commonWorldHealthOrganizationCoronavirusAppVersion(packageInfo.version, packageInfo.buildNumber)}\n'
        : null;

    final String copyrightString = S
        .of(context)
        .commonWorldHealthOrganizationCoronavirusCopyright(DateTime.now().year);

    return PageScaffold(context,
        title: S.of(context).homePagePageTitle,
        subtitle: S.of(context).homePagePageSubTitle,
        showBackButton: false,
        showLogoInHeader: true,
        body: [
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverStaggeredGrid.count(
              crossAxisCount: 2,
              staggeredTiles: [
                StaggeredTile.count(1, 2 * tileHeightFactor),
                StaggeredTile.count(1, tileHeightFactor),
                StaggeredTile.count(1, tileHeightFactor),
                StaggeredTile.count(2, tileHeightFactor),
                StaggeredTile.count(1, tileHeightFactor),
                StaggeredTile.count(1, tileHeightFactor),
              ],
              children: [
                PageButton(
                  Color(0xff008DC9),
                  S.of(context).homePagePageButtonProtectYourself,
                  () {
                    _logAnalyticsEvent('ProtectYourself');
                    return Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => ProtectYourself()));
                  },
                ),
                PageButton(
                  Color(0xff1A458E),
                  S.of(context).homePagePageButtonLatestNumbers,
                  () {
                    _logAnalyticsEvent('LatestNumbers');
                    return Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => LatestNumbers()));
                  },
                  mainAxisAlignment: MainAxisAlignment.start,
                  titleStyle:
                      TextStyle(fontSize: 11.2, fontWeight: FontWeight.w700),
                ),
                PageButton(
                  Color(0xff3DA7D4),
                  S.of(context).homePagePageButtonYourQuestionsAnswered,
                  () {
                    _logAnalyticsEvent('QuestionsAnswered');
                    return Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => QuestionIndexPage(
                              dataSource: QuestionData.yourQuestionsAnswered,
                              title: S.of(context).homePagePageButtonQuestions,
                            )));
                  },
                  mainAxisAlignment: MainAxisAlignment.start,
                  titleStyle:
                      TextStyle(fontSize: 11.2, fontWeight: FontWeight.w700),
                ),
                PageButton(
                  Color(0xff234689),
                  S.of(context).homePagePageButtonWHOMythBusters,
                  () {
                    _logAnalyticsEvent('GetTheFacts');
                    return Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => QuestionIndexPage(
                              dataSource: QuestionData.whoMythbusters,
                              title: S
                                  .of(context)
                                  .homePagePageButtonWHOMythBusters,
                            )));
                  },
                  description:
                      S.of(context).homePagePageButtonWHOMythBustersDescription,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                PageButton(
                  Color(0xff3DA7D4),
                  S.of(context).homePagePageButtonTravelAdvice,
                  () {
                    _logAnalyticsEvent('TravelAdvice');
                    return Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => TravelAdvice()));
                  },
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                PageButton(
                  Color(0xff008DC9),
                  S.of(context).homePagePageButtonNewsAndPress,
                  () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => NewsFeed())),
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
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
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 23),
                      color: Color(0xffCA6B35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(S.of(context).homePagePageSliverListDonate),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      onPressed: () {
                        _logAnalyticsEvent('Donate');
                        launch(S.of(context).homePagePageSliverListDonateUrl);
                      })),
              Divider(height: 1),
              Material(
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Icon(Icons.share, color: Color(0xffCA6B35)),
                  title: Text(
                    S.of(context).homePagePageSliverListShareTheApp,
                    style: TextStyle(
                      color: Color(0xffCA6B35),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFC9CDD6),
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
              Divider(height: 1),
              Material(
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Icon(Icons.settings, color: Color(0xffCA6B35)),
                  title: Text(
                    S.of(context).homePagePageSliverListSettings,
                    style: TextStyle(
                        color: Color(0xffCA6B35),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFC9CDD6),
                  ),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => SettingsPage())),
                ),
              ),
              Divider(height: 1),
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
              Divider(height: 0),
              Container(
                height: 25,
              ),
              Text(
                '${versionString ?? ''}$copyrightString',
                style: TextStyle(color: Color(0xff26354E)),
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
