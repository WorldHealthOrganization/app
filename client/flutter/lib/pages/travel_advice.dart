import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class TravelAdvice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        showShareBottomBar: false,
        announceRouteManually: true,
        body: [
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Color(0xffD82037),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Html(
                data: S.of(context).travelAdviceContainerText,
                defaultTextStyle: TextStyle(
                  color: Colors.white,
                  // The Html widget isn't using the textScaleFactor so here's
                  // the next best place to incorporate it
                  fontSize: 18 * MediaQuery.textScaleFactorOf(context),
                  height: 1.2,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Semantics(
                header: true,
                  child: Text(
                  S.of(context).travelAdvicePageListTitle,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xff050C1D)),
                ),
              ),
            ),
            TravelAdviceListItem(
              imageSrc: S.of(context).travelAdvicePageListItem1Image,
              description:
                  S.of(context).travelAdvicePageListItem1Text,
            ),
            TravelAdviceListItem(
              imageSrc: S.of(context).travelAdvicePageListItem2Image,
              description:
                  S.of(context).travelAdvicePageListItem2Text,
            ),
            TravelAdviceListItem(
              imageSrc: S.of(context).travelAdvicePageListItem3Image,
              description:
                  S.of(context).travelAdvicePageListItem3Text,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: PageButton(
                Color(0xff008DC9),
                S.of(context).travelAdvicePageButtonGeneralRecommendations,
                () => launch(S.of(context).travelAdvicePageButtonGeneralRecommendationsLink),
                description:
                    S.of(context).travelAdvicePageButtonGeneralRecommendationsDescription,
                verticalPadding: 16,
                titleStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                descriptionColor: Colors.white,
              ),
            )
          ])),
        ],
        title: S.of(context).homePagePageButtonTravelAdvice);
  }
}

class TravelAdviceListItem extends StatelessWidget {
  final String description;
  final String imageSrc;
  TravelAdviceListItem({@required this.description, @required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              this.imageSrc,
              height: 109,
              width: 109,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
              child: Text(
            this.description,
            style: TextStyle(fontSize: 18, color: Color(0xff3C4245)),
          )),
        ],
      ),
    );
  }
}
