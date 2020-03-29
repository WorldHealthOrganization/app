import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/pages/question_index.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/onboarding/location_sharing.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var onboardingComplete = await UserPreferences().getOnboardingCompleted();
    if (!onboardingComplete) {
      // TODO: This should be a bottom-up slide.
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (c) => LocationSharing()));
      await UserPreferences().setOnboardingCompleted(true);
    }
  }

  _launchStatsDashboard() async {
    const url = 'https://experience.arcgis.com/experience/685d0ace521648f8a5beeeee1b9125cd';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SafeArea(
          child: CustomScrollView(slivers: [
            SliverAppBar(
                expandedHeight: 110,
                backgroundColor: Colors.white,
                flexibleSpace: Image.asset("assets/WHO.jpg")),
            SliverStaggeredGrid.count(
              crossAxisCount: 2,
              staggeredTiles: [
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(2, .5),
              ],
              children: [
                PageButton(
                  Color(0xff3b8bc4),
                  S.of(context).homePagePageButtonProtectYourself,
                  () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => ProtectYourself())),
                ),
                PageButton(
                  Color(0xfff6c35c),
                  S.of(context).homePagePageButtonLatestNumbers,
                  _launchStatsDashboard,
                ),
                PageButton(
                  Color(0xffbe7141),
                  S.of(context).homePagePageButtonYourQuestionsAnswered,
                  () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => QuestionIndexPage())),
                ),
                PageButton(
                  Color(0xff234689),
                  S.of(context).homePagePageButtonWHOMythBusters,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => WhoMythBusters()),
                  ),
                  description:
                      "Learn the facts about Coronavirus and how to prevent the spread",
                  centerVertical: true,
                ),
                PageButton(
                  Color(0xffba4344),
                  S.of(context).homePagePageButtonTravelAdvice,
                  () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => TravelAdvice())),
                  borderRadius: 50,
                  centerVertical: true,
                ),
              ],
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                ListTile(
                  title: Text(S.of(context).homePagePageSliverListShareTheApp),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => Share.share(
                      'Check out the official COVID-19 Guide App https://www.who.int/covid-19-app'),
                ),
                ListTile(
                  title: Text(S.of(context).homePagePageSliverListAboutTheApp),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showAboutDialog(
                      context: context,
                      applicationLegalese: S
                          .of(context)
                          .homePagePageSliverListAboutTheAppDialog),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
