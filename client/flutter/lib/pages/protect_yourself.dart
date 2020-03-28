import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListOfItems(
      [
        ListItem(
          titleWidget: EmojiHeader("🧼"),
          message: S.of(context).protectYourselfListOfItemsPageListItem1,
        ),
        ListItem(
          titleWidget: EmojiHeader("👄"),
          message: S.of(context).protectYourselfListOfItemsPageListItem2,
        ),
        ListItem(
          titleWidget: EmojiHeader("💪"),
          message: S.of(context).protectYourselfListOfItemsPageListItem3,
        ),
        ListItem(
          titleWidget: EmojiHeader("🚷"),
          message: S.of(context).protectYourselfListOfItemsPageListItem4,
        ),
        ListItem(
          titleWidget: EmojiHeader("🏠"),
          message: S.of(context).protectYourselfListOfItemsPageListItem5,
        ),
        ListItem(
          titleWidget: EmojiHeader("🤒"),
          message: S.of(context).protectYourselfListOfItemsPageListItem6,
        ),
        ListItem(
          titleWidget: EmojiHeader("ℹ️"),
          message: S.of(context).protectYourselfListOfItemsPageListItem7,
        ),
      ],
    );
  }
}
