//TODO: ENTER CORRECT URL FOR EACH ITEM

import 'package:WHOFlutter/components/news_feed_item.dart';
import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context,
      body: [
        SliverList(
            delegate: SliverChildListDelegate([
          NewsFeedItem(
            title: "Situation Reports",
            description:
                "Situation reports provide the latest updates on the novel coronavirus outbreak.",
            imageProvider:
                AssetImage("assets/news_press/news_situation_reports.png"),
            url: "https://who.int",
          ),
          NewsFeedItem(
            title: "Rolling Updates",
            description:
                "Rolling updates on coronavirus disease (COVID-19) sourced from across WHO media.",
            imageProvider: AssetImage("assets/news_press/rolling_updates.png"),
            url: "https://who.int",
          ),
          NewsFeedItem(
            title: "News Articles",
            description:
                "All news releases, statements, and notes for the media.",
            imageProvider: AssetImage("assets/news_press/news_articles.png"),
            url: "https://who.int",
          ),
          NewsFeedItem(
            title: "Press Briefings",
            description:
                "Coronavirus disease (COVID019) press briefings including videos, audio and transcripts.",
            imageProvider: AssetImage("assets/news_press/press_briefings.png"),
            url: "https://who.int",
          )
        ]))
      ],
      title: "News & Press",
    );
  }
}
