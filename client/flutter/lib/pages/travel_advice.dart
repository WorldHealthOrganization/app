import 'package:flutter/material.dart';
import 'package:WHOFlutter/constants.dart';

class TravelAdvice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          color: Color(0xffD82037),
          padding: EdgeInsets.all(26),
          margin: EdgeInsets.only(top: 100),
          child: Text(
            "WHO continues to advise against the application of travel or trade restrictions to countries experiencing COVID-19 outbreaks.\n\nIt is prudent for travellers who are sick to delay or avoid travel to affected areas, in particular for elderly travellers and people with chronic diseases or underlying healh conditions. “Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contract to areas reporting only imported cases.",
            style: TextStyle(color: Colors.white),
            textScaleFactor: 1.2,
          ),
        ),
        Container(
            padding: EdgeInsets.all(26),
            child: Text("Travellers returning from affected areas should",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold))),
        HorrizontalListItem(
            null,
            "Self-monitor for symptoms for 14 days and follow national protocols of receiving countries.",
            MediaQuery.of(context).size.width),
        HorrizontalListItem(
            null,
            "Some countries may require returning travellers to enter quarantine.",
            MediaQuery.of(context).size.width),
        HorrizontalListItem(
            null,
            "If symptoms occur, travellers are advsed to contact local health care providers, preferably by phone, and inform them of their symptoms and travel history.",
            MediaQuery.of(context).size.width),
        Container(
          padding: EdgeInsets.only(top: 43, left: 16, right: 16, bottom: 275),
          child: FlatButton(
            padding: EdgeInsets.all(18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Constants.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "General\nRecommendations",
                  textScaleFactor: 2.1,
                ),
                Container(
                  height: 20,
                ),
                Text(
                  "Learn the facts about Coronavirus and how to prevent the spread",
                  textScaleFactor: 1.1,
                ),
              ],
            ),
            onPressed: () {},
          ),
        )
      ],
    ));
  }
}

Widget HorrizontalListItem(String img, String text, double width) {
  return Container(
    height: 109,
    width: width,
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 109,
          width: 109,
          //Color is a placeholder for the image
          color: Colors.blue,
          // child: Image(image: AssetImage(img)),
        ),
        Container(
          width: width - 109 - 42,
          child: Text(
            text,
            textScaleFactor: 1.2,
          ),
        )
      ],
    ),
  );
}
