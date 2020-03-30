import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const double youtubeAspectRatio = (16.0 / 9.0);

class YoutubeEmbed extends StatelessWidget {
  final String youtubeId;

  const YoutubeEmbed(this.youtubeId);

  String get youtubeEmbedUrl => 'https://www.youtube.com/embed/$youtubeId?autoplay=0&controls=0&disablekb=1&enablejsapi=0&fs=0&iv_load_policy=3&modestbranding=1&playsinline=1';

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: youtubeAspectRatio,
      child: WebView(
        initialUrl: youtubeEmbedUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
