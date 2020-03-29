import 'package:WHOFlutter/components/web_view_widget.dart';
import 'package:flutter/material.dart';

class NewsAndPress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        title: "News and Press",
        externalUrl: "https://www.who.int/news-room/releases",
      ),
    );
  }
}
