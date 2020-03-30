//TODO: ENTER CORRECT URL FOR EACH ITEM

import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class NewsFeedItem extends StatelessWidget {
  final String title;
  final String description;
  final ImageProvider imageProvider;
  final String url;

  NewsFeedItem(
      {@required this.title,
      @required this.description,
      @required this.imageProvider,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => launch(this.url),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  this.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    height: 109,
                    width: 109,
                    image: this.imageProvider,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text(
                  this.description,
                  style: TextStyle(fontSize: 18),
                )),
                Center(child: Icon(Icons.arrow_forward_ios)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
