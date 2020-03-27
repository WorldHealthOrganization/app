import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/listViewPage.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListOfItemsPage(
      [
        ListItem(
            titleWidget: EmojiHeader("🧼"), message: S.of(context).washHands),
        ListItem(
            titleWidget: EmojiHeader("👄"),
            message: "Avoid touching your eyes, mouth, and nose"),
        ListItem(
            titleWidget: EmojiHeader("💪"),
            message:
                "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze"),
        ListItem(
            titleWidget: EmojiHeader("🚷"), message: "Avoid crowded places"),
        ListItem(
            titleWidget: EmojiHeader("🏠"),
            message:
                "Stay at home if you feel unwell - even with a slight fever and cough"),
        ListItem(
            titleWidget: EmojiHeader("🤒"),
            message:
                "If you have a fever, cough and difficulty breathing, seek medical care early but call by phone first!"),
        ListItem(
            titleWidget: EmojiHeader("ℹ️"),
            message: "Stay aware of the latest information from WHO"),
      ],
    );
  }
}
