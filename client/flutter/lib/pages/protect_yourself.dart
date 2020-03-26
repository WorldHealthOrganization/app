import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide(
        titleWidget: EmojiHeader("🧼"),
        message: S.of(context).washHands,
      ),
      CarouselSlide(
        titleWidget: EmojiHeader("👄"),
        message: "Avoid touching your eyes, mouth, and nose",
      ),
      CarouselSlide(
        titleWidget: EmojiHeader("💪"),
        message:
            "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze",
      ),
      CarouselSlide(
        titleWidget: EmojiHeader("🚷"),
        message: "Avoid crowded places",
      ),
      CarouselSlide(
        titleWidget: EmojiHeader("🏠"),
        message:
            "Stay at home if you feel unwell - even with a slight fever and cough",
      ),
      CarouselSlide(
        titleWidget: EmojiHeader("🤒"),
        message:
            "If you have a fever, cough and difficulty breathing, seek medical care early but call by phone first!",
      ),
      CarouselSlide(
        titleWidget: EmojiHeader("ℹ️"),
        message: "Stay aware of the latest information from WHO",
      ),
    ]);
  }
}
