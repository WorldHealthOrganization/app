import 'package:WHOFlutter/components/emojiHeader.dart';
import 'package:WHOFlutter/components/listItem.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class WhoMythBusters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
        showShareBottomBar: true,
        body: [
          SliverList(
              delegate: SliverChildListDelegate([
            ListItem(
              titleWidget: EmojiHeader("🧠"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem1,
            ),
            ListItem(
              titleWidget: EmojiHeader("🔢"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem2,
            ),
            ListItem(
              titleWidget: EmojiHeader("❄️"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem3,
            ),
            ListItem(
              titleWidget: EmojiHeader("☀️"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem4,
            ),
            ListItem(
              titleWidget: EmojiHeader("🦟"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem5,
            ),
            ListItem(
              titleWidget: EmojiHeader("🐶"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem6,
            ),
            ListItem(
              titleWidget: EmojiHeader("🛀"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem7,
            ),
            ListItem(
              titleWidget: EmojiHeader("💨"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem8,
            ),
            ListItem(
              titleWidget: EmojiHeader("🟣"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem9,
            ),
            ListItem(
              titleWidget: EmojiHeader("🌡️"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem10,
            ),
            ListItem(
              titleWidget: EmojiHeader("💦"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem11,
            ),
            ListItem(
              titleWidget: EmojiHeader("💉"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem12,
            ),
            ListItem(
              titleWidget: EmojiHeader("👃"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem13,
            ),
            ListItem(
              titleWidget: EmojiHeader("🧄"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem14,
            ),
            ListItem(
              titleWidget: EmojiHeader("💊"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem15,
            ),
            ListItem(
              titleWidget: EmojiHeader("🧪"),
              message: S.of(context).whoMythBustersListOfItemsPageListItem16,
            ),
          ]))
        ],
        title: S.of(context).homePagePageButtonWHOMythBusters);
  }
}
