import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:WHOFlutter/models/question.dart';
import 'package:WHOFlutter/providers/question/index_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class QuestionIndexPage extends StatelessWidget {
  final String title;
  final QuestionType type;

  QuestionIndexPage({this.title, this.type});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionIndexProvider>(
      create: (_) => QuestionIndexProvider(
        type: type,
        context: context,
      ),
      child: Scaffold(
        body: Consumer<QuestionIndexProvider>(
          builder: (_, provider, __) {
            return PageScaffold(
              context,
              body: [
                provider.questions.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          provider.questions
                              .map((question) => _buildQuestion(question))
                              .toList(),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: CupertinoActivityIndicator(),
                        ),
                      )
              ],
              title: title,
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestion(Question question) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        Divider(),
        ExpansionTile(
          key: PageStorageKey<String>(question.title),
          trailing: Icon(
            Icons.add_circle_outline,
            color: Colors.black,
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _html(question.title),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 32, bottom: 32),
              child: _html(question.body),
            )
          ],
        ),
      ]),
    );
  }

  // flutter_html supports a subset of html: https://pub.dev/packages/flutter_html
  Widget _html(String html) {
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
