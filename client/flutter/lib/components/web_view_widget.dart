import 'package:WHOFlutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewWidget extends StatefulWidget {
  final String externalUrl;
  final String title;

  WebViewWidget({Key key, @required this.title, @required this.externalUrl})
      : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.externalUrl,
        withJavascript: true,
        withZoom: false,
        hidden: false,
        appBar: AppBar(title: Text(widget.title), elevation: 1),
        initialChild: Container(
            color: Constants.backgroundColor,
            child: const Center(
              child: Text('Loading...'),
            )));
  }
}
