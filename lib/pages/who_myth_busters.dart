import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

class WhoMythBusters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselView([
      CarouselSlide(
          EmojiHeader("🧠"),
          "There is a lot of false information around. These are the facts",
          context),
      CarouselSlide(
          EmojiHeader("🔢"),
          "People of all ages CAN be infected by the coronavirus. Older people, and people with pre-existing medical conditions (such as asthma, diabetes, heart disease) appear to be more vulnerable to becoming severely ill with the virus",
          context),
      CarouselSlide(EmojiHeader("❄️"),
          "Cold weather and snow CANNOT kill the coronavirus", context),
      CarouselSlide(
          EmojiHeader("☀️"),
          "The coronavirus CAN be transmitted in areas with hot and humid climates",
          context),
      CarouselSlide(
          EmojiHeader("🦟"),
          "The coronavirus CANNOT be transmitted through mosquito bites",
          context),
      CarouselSlide(
          EmojiHeader("🐶"),
          "There is NO evidence that companion animals/pets such as dogs or cats can transmit the coronavirus",
          context),
      CarouselSlide(EmojiHeader("🛀"),
          "Taking a hot bath DOES NOT prevent the coronavirus", context),
      CarouselSlide(EmojiHeader("💨"),
          "Hand dryers are NOT effective in killing the coronavirus", context),
      CarouselSlide(
          EmojiHeader("🟣"),
          "Ultraviolet light SHOULD NOT be used for sterilization and can cause skin irritation",
          context),
      CarouselSlide(
          EmojiHeader("🌡️"),
          "Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus",
          context),
      CarouselSlide(
          EmojiHeader("💦"),
          "Spraying alcohol or chlorine all over your body WILL NOT kill viruses that have already entered your body",
          context),
      CarouselSlide(
          EmojiHeader("💉"),
          "Vaccines against pneumonia, such as pneumococcal vaccine and Haemophilus influenzae type b (Hib) vaccine, DO NOT provide protection against the coronavirus",
          context),
      CarouselSlide(
          EmojiHeader("👃"),
          "There is NO evidence that regularly rinsing the nose with saline has protected people from infection with the coronavirus",
          context),
      CarouselSlide(
          EmojiHeader("🧄"),
          "Garlic is healthy but there is NO evidence from the current outbreak that eating garlic has protected people from the coronavirus",
          context),
      CarouselSlide(
          EmojiHeader("💊"),
          "Antibiotics DO NOT work against viruses, antibiotics only work against bacteria",
          context),
      CarouselSlide(
          EmojiHeader("🧪"),
          "To date, there is NO specific medicine recommended to prevent or treat the coronavirus",
          context),
    ]);
  }
}
