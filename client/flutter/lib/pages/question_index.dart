import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:WHOFlutter/components/question_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

typedef QuestionIndexDataSource = Future<List<QuestionItem>> Function();

/// A Data driven series of questions and answers using HTML fragments.
class QuestionIndexPage extends StatefulWidget {
  final String title;
  final QuestionIndexDataSource dataSource;

  const QuestionIndexPage(
      {Key key, @required this.title, @required this.dataSource})
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
    return PageScaffold(
      context,
      body: [
        SliverList(
          delegate: SliverChildListDelegate(items),
        )
      ],
      title: widget.title,
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
