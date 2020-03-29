import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String externalUrl;
  final String title;

  WebViewWidget({Key key, @required this.title, @required this.externalUrl})
      : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Future _navigate(BuildContext context) async {
    WebViewController webViewController = await _controller.future;

    if (await webViewController.canGoBack()) {
      await webViewController.goBack();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _navigate(context),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
          body: Builder(builder: (BuildContext context) {
            return WebView(
                initialUrl: widget.externalUrl,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                });
          })),
    );
  }
}
