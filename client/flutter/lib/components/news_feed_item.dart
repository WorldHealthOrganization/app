import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_app/constants.dart';

class NewsFeedItem extends StatelessWidget {
  final String title;
  final String description;
  final ImageProvider imageProvider;
  final String url;

  NewsFeedItem({
    @required this.title,
    @required this.description,
    @required this.imageProvider,
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => launch(this.url),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  this.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: isLight(context)
                        ? Constants.textColor
                        : Constants.darkModeTextColor,
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
                        style: TextStyle(
                          fontSize: 18,
                          color: isLight(context)
                              ? Constants.textColor
                              : Constants.darkModeTextColor,
                        ),
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
