import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share/share.dart';

class HomePage extends StatelessWidget {
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
                  () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => ProtectYourself())),
                ),
                PageButton(
                  Color(0xffbe7141),
                  S.of(context).homePagePageButtonYourQuestionsAnswered,
                  () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => ProtectYourself())),
                ),
                PageButton(
                  Color(0xff234689),
                  S.of(context).homePagePageButtonWHOMythBusters,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => WhoMythBusters()),
                  ),
                  description:
                      "Learn the facts about Coronavirus and how to prevent the spread",
                  centerItems: true,
                ),
                PageButton(
                  Color(0xffba4344),
                  S.of(context).homePagePageButtonTravelAdvice,
                  () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => TravelAdvice())),
                  borderRadius: 50,
                  centerItems: true,
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
                  title: Text(S.of(context).homePagePageSliverListProvideFeedback),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(S.of(context).homePagePageSliverListAboutTheApp),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => showAboutDialog(
                      context: context,
                      applicationLegalese: S.of(context).homePagePageSliverListAboutTheAppDialog
                  ),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton(this.backgroundColor, this.title, this.onPressed,
      {this.description = "",
      this.borderRadius = 25.0,
      this.centerItems = false});

  final Color backgroundColor;
  final String title;
  final String description;
  final double borderRadius;
  final Function onPressed;
  final bool centerItems;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.borderRadius)),
      color: backgroundColor,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: this.centerItems
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            children: <Widget>[
              Text(
                this.title,
                textScaleFactor: 1.5,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              this.description.isNotEmpty
                  ? Text(
                      this.description,
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.35,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )
                  : Container()
            ],
          )),
      onPressed: this.onPressed,
    );
  }
}
