import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/api/question_data.dart';
import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:WHOFlutter/pages/news_feed.dart';
import 'package:WHOFlutter/pages/question_index.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/location_sharing_page.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'onboarding/notifications_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _initStateAsync();
  }

  void _initStateAsync() async {
    await _pushOnboardingIfNeeded();
  }

  _launchStatsDashboard() async {
    var url = S.of(context).homePagePageButtonLatestNumbersUrl;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
        title: "Corona Virus",
        subtitle: "Virus response & tools",
        showBackButton: false,
        body: [
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverStaggeredGrid.count(
              crossAxisCount: 2,
              staggeredTiles: [
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
              ],
              children: [
                PageButton(
                  Color(0xff008DC9),
                  S.of(context).homePagePageButtonProtectYourself,
                  () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => ProtectYourself())),
                ),
                PageButton(
                  Color(0xff1A458E),
                  S.of(context).homePagePageButtonLatestNumbers,
                  _launchStatsDashboard,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                PageButton(
                  Color(0xff3DA7D4),
                  S.of(context).homePagePageButtonYourQuestionsAnswered,
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => QuestionIndexPage(
                            dataSource: QuestionData.yourQuestionsAnswered,
                            title: "Questions",
                          ))), // TODO: Localize
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                PageButton(
                  Color(0xff234689),
                  S.of(context).homePagePageButtonWHOMythBusters,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (c) => QuestionIndexPage(
                              dataSource: QuestionData.whoMythbusters,
                              title: "WHO Myth-busters",
                            )),
                  ),
                  description:
                      S.of(context).homePagePageButtonWHOMythBustersDescription,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                PageButton(
                  Color(0xff3DA7D4),
                  S.of(context).homePagePageButtonTravelAdvice,
                  () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => TravelAdvice())),
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                PageButton(
                  Color(0xff008DC9),
                  "News\n& Press",
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
                  "Help support the relief effort",
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
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 23),
                    color: Color(0xffCA6B35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Donate here"),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    onPressed: () =>
                        launch("https://www.who.int/Covid19ResponseFund")),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text(S.of(context).homePagePageSliverListShareTheApp),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Share.share(
                    S.of(context).commonWhoAppShareIconButtonDescription),
              ),
              ListTile(
                title: Text(S.of(context).homePagePageSliverListAboutTheApp),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => showAboutDialog(
                    context: context,
                    applicationLegalese:
                        S.of(context).homePagePageSliverListAboutTheAppDialog),
              ),
              Container(
                height: 25,
              ),
              Text(
                "Version 0.1 (12412)\n© 2020 WHO",
                style: TextStyle(color: Color(0xff26354E)),
                textAlign: TextAlign.center,
              ), //TODO: pull these values in
              Container(
                height: 40,
              ),
            ]),
          )
        ]);
  }

  Future _pushOnboardingIfNeeded() async {
    var onboardingComplete = await UserPreferences().getOnboardingCompleted();

    // TODO: Uncomment for testing.  Remove when appropriate.
    // onboardingComplete = false;

    if (!onboardingComplete) {
      // TODO: We should wrap these in a single Navigation context so that they can
      // TODO: slide up as a modal, proceed with pushes left to right, and then be
      // TODO: dismissed together.
      await Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true, builder: (c) => LocationSharingPage()));
      await Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true, builder: (c) => NotificationsPage()));

      await UserPreferences().setOnboardingCompleted(true);
    }
  }
}
