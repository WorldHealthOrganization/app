import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class NewsFeedItem extends StatelessWidget {
  final String title;
  final String description;
  final ImageProvider imageProvider;
  final String url;
  final FirebaseAnalytics analytics;

  NewsFeedItem({
    @required this.title,
    @required this.description,
    @required this.imageProvider,
    @required this.url,
    @required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: () => {
        analytics.logEvent(name: 'NewsFeedItem', parameters: {'url': url});
        launch(this.url);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              this.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 28,
              ),
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
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffC9CDD6),
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    ));
  }
}
