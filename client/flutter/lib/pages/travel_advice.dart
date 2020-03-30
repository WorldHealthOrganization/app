import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TravelAdvice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
        body: [
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Color(0xffD82037),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                "WHO continues to advise against the application of travel or trade restrictions to countries experiencing COVID-19 outbreaks. It is prudent for travellers who are sick to delay or avoid travel to affected areas, in particular for elderly travellers and people with chronic diseases or underlying healh conditions. “Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contract to areas reporting only imported cases.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                S.of(context).travelAdviceListOfItemsPageListItem11,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            TravelAdviceListItem(
              imageSrc: "assets/travel_advice/self-monitor.png",
              description:
                  "Self-monitor for symptoms for 14 days and follow national protocols of receiving countries",
            ),
            TravelAdviceListItem(
              imageSrc: "assets/travel_advice/quarantine.png",
              description:
                  "Some countries may require returning travellers to enter quarantine.",
            ),
            TravelAdviceListItem(
              imageSrc: "assets/travel_advice/doctor.png",
              description:
                  "If symptoms occur, travellers are advsed to contact local health care providers, preferably by phone, and inform them of their symptoms and travel history.",
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: PageButton(
                Color(0xff008DC9),
                "General\nRecommendations",
                () => launch("https://who.int"),
                description:
                    "Learn the facts about Coronavirus and how to prevent the spread",
                verticalPadding: 16,
                titleStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            style: TextStyle(fontSize: 18),
          )),
        ],
      ),
    );
  }
}
