import 'package:WHOFlutter/api/question_data.dart';
import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

typedef QuestionIndexDataSource = Future<List<QuestionItem>> Function(
    BuildContext);

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
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // Fetch the question data.
    // Note: this depends on the build context for the locale and hence is not
    // Note: available at the usual initState() time.
    // TODO: We should detect a schema version problem here and display a dialog
    // TODO: prompting the user to upgrade.
    if (_questions == null) {
      _questions = await widget.dataSource(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildPage());
  }

  // TODO: Should show a spinner while loading.
  Widget _buildPage() {
    List items = (_questions ?? [])
        .map((questionData) => QuestionTile(
              questionItem: questionData,
            ))
        .toList();

    return PageScaffold(
      context,
      body: [
        items.isNotEmpty
            ? SliverList(
                delegate: SliverChildListDelegate(items),
              )
            : SliverToBoxAdapter(
                child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: CupertinoActivityIndicator(),
              ))
      ],
      title: widget.title,
    );
  }

  // flutter_html supports a subset of html: https://pub.dev/packages/flutter_html
}

class QuestionTile extends StatefulWidget {
  const QuestionTile({
    @required this.questionItem,
  });

  final QuestionItem questionItem;

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Divider(
          height: 1,
        ),
        ExpansionTile(
          onExpansionChanged: (v){
            setState(() {
              isExpanded = v;
            });
          },
          key: PageStorageKey<String>(widget.questionItem.title),
          trailing: Transform.rotate(
            angle: this.isExpanded?45:0,
                    child: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
          ),
          title: html(widget.questionItem.title),
          
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
              child: html(widget.questionItem.body),
            )
          ],
        )
      ]),
    );
  }

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
              return baseStyle
                  .merge(TextStyle(fontSize: 20, color: Colors.black));
          }
        }
        return baseStyle.merge(TextStyle(color: Colors.black));
      },
    );
  }
}
