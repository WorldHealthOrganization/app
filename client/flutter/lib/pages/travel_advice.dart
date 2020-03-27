import 'package:WHOFlutter/listViewPage.dart';
import 'package:flutter/material.dart';

class TravelAdvice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListOfItemsPage([
      ListItem(
        message: "WHO continues to advise against the application of travel or trade restrictions to countries experiencing COVID-19 outbreaks…"
      ),
      ListItem(
        message: "It is prudent for travellers who are sick to delay or avoid travel to affected areas, in particular for elderly travellers and people with chronic diseases or underlying health conditions…"
      ),
      ListItem(
        message: "“Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contrast to areas reporting only imported cases…"
      ),
      ListItem(
        message: "General recommendations for all travellers include…"
      ),
      ListItem(
        titleWidget: EmojiHeader("🧼"),
        message: "Wash your hands frequently"
      ),
      ListItem(
        titleWidget: EmojiHeader("👄"),
        message: "Avoid touching your eyes, mouth and nose"
      ),
      ListItem(
        titleWidget: EmojiHeader("💪"),
        message: "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze"
      ),
      ListItem(
        titleWidget: EmojiHeader("↔️"),
        message: "Stay more than 1 meter (3 feet) away from a person who is sick"
      ),
      ListItem(
        titleWidget: EmojiHeader("🍗"),
        message: "Follow proper food hygiene practices"
      ),
      ListItem(
        titleWidget: EmojiHeader("😷"),
        message: "Only wear a mask if you are ill with COVID-19 symptoms (especially coughing) or looking after someone who may have COVID-19"
      ),
      ListItem(
        message: "Travellers returning from affected areas should:",
      ),
      ListItem(
        titleWidget: EmojiHeader("🌡"),
        message: "Self-monitor for symptoms for 14 days and follow national protocols of receiving countries. Some countries may require returning travellers to enter quarantine",
      ),
      ListItem(
        titleWidget: EmojiHeader("🌡️"),
        message: "Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus",
      ),
      ListItem(
        titleWidget: EmojiHeader("🤒"),
        message: "If symptoms occur, such as fever, or cough or difficulty breathing, travellers are advised to contact local health care providers, preferably by phone, and inform them of their symptoms and their travel history",
      ),
    ]);
  }
}
