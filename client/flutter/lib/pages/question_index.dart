import 'package:WHOFlutter/components/back_arrow.dart';
import 'package:WHOFlutter/components/question_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

typedef QuestionIndexDataSource = Future<List<QuestionItem>> Function();

/// A Data driven series of questions and answers using HTML fragments.
class QuestionIndexPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final QuestionIndexDataSource dataSource;

  const QuestionIndexPage(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.dataSource})
      : super(key: key);

  @override
  _QuestionIndexPageState createState() => _QuestionIndexPageState();
}

class _QuestionIndexPageState extends State<QuestionIndexPage> {
  List<QuestionItem> _questions;

  @override
  void initState() {
    super.initState();
    _initStateAsync();
  }

  void _initStateAsync() async {
    // Fetch the dynamic query data. This is a placeholder.
    _questions = await widget.dataSource();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildPage());
  }

  Widget _buildPage() {
    var items = (_questions ?? []).map(_buildQuestion).toList();
    return Material(
      color: Colors.grey.shade200,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            // Hide the built-in icon for now
            iconTheme: IconThemeData(
              color: Colors.transparent,
            ),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(background: _buildHeader()),
            expandedHeight: 120,
          ),
          SliverList(
            delegate: SliverChildListDelegate(items),
          ),
        ],
      ),
    );
  }

  SafeArea _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildBackArrow(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.title,
                      textScaleFactor: 1.8,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(widget.subtitle,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              Image.asset('assets/images/mark.png', width: 75),
            ]),
      ),
    );
  }

  // TODO: Factor this out with the other pages?
  GestureDetector _buildBackArrow() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: BackArrow(),
    );
  }

  Widget _buildQuestion(QuestionItem questionItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey.shade400,
        child: ExpansionTile(
          key: PageStorageKey<String>(questionItem.title),
          trailing: Icon(Icons.add),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: html(questionItem.title),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 32, bottom: 32),
              child: html(questionItem.body),
            )
          ],
        ),
      ),
    );
  }

  // flutter_html supports a subset of html: https://pub.dev/packages/flutter_html
  Widget html(String html) {
    return Html(
      data: html,
      defaultTextStyle: TextStyle(fontSize: 16.0),
      linkStyle: const TextStyle(
        color: Colors.deepPurple,
      ),
      onLinkTap: (url) {
        launch(url, forceSafariVC: false);
      },
      onImageTap: (src) {},
      // This is our css :)
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "h2":
              return baseStyle.merge(TextStyle(fontSize: 20));
          }
        }
        return baseStyle;
      },
    );
  }
}
