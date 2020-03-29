import 'dart:io';

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
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

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
    //var onboardingComplete = await UserPreferences().//getOnboardingCompleted();
    //print('Onbardingcomplete : ' + onboardingComplete.toString());
    
    //Checking permission directly in the _initStateAsync() function
    PermissionStatus _status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    print(_status.value.toString());
    if (_status.value == 0) {
      
      // TODO: This should be a bottom-up slide.
      
      //created a Bottom Up slide that will pop up everytime home page is triggered if the user hasn't given location access
      await showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
          context: context,
          builder: (context) {
            return LocationSharing();
          });
      // await UserPreferences().setOnboardingCompleted(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SafeArea(
          child: CustomScrollView(
              physics:
                  (Platform.isIOS) ? BouncingScrollPhysics() : ScrollPhysics(),
              slivers: [
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
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => ProtectYourself())),
                    ),
                    PageButton(
                      Color(0xffbe7141),
                      S.of(context).homePagePageButtonYourQuestionsAnswered,
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => QuestionIndexPage())),
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
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => TravelAdvice())),
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
                      title:
                          Text(S.of(context).homePagePageSliverListShareTheApp),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => Share.share(
                          'Check out the official COVID-19 Guide App https://www.who.int/covid-19-app'),
                    ),
                    ListTile(
                      title:
                          Text(S.of(context).homePagePageSliverListAboutTheApp),
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
