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
              color: Color(0xff008DC9),
              imageProvider: AssetImage("assets/news_press/news_situation_reports.svg")),
          NewsFeedItem(
              title: "Rolling Updates",
              description:
                  "Rolling updates on coronavirus disease (COVID-19) sourced from across WHO media.",
              color: Color(0xff3DA7D4),
              imageProvider: AssetImage("assets/news_press/rolling_updates.svg")),
          NewsFeedItem(
              title: "News Articles",
              description:
                  "All news releases, statements, and notes for the media.",
              color: Color(0xff3DA7D4),
              imageProvider: AssetImage("assets/news_press/news_articles.svg")),
          NewsFeedItem(
              title: "Press Briefings",
              description:
                  "Coronavirus disease (COVID019) press briefings including videos, audio and transcripts.",
              color: Color(0xffB8DBEA),
              imageProvider: AssetImage("assets/news_press/press_briefings.svg"))
        ]))
      ],
      title: "News & Press",
    );
  }
}

class NewsFeedItem extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final ImageProvider imageProvider;

  NewsFeedItem(
      {@required this.title,
      @required this.description,
      @required this.color,
      @required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                  color: this.color,
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
    );
  }
}
