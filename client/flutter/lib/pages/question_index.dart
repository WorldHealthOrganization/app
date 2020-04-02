import 'package:WHOFlutter/providers/question/index_provider.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/widgets/question_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A Data driven series of questions and answers using HTML fragments.
class QuestionIndexPage extends StatelessWidget {
  final String title;
  final QuestionIndexType type;

  QuestionIndexPage({Key key, @required this.title, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionIndexProvider(
        context: context,
        type: type,
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
                              .map((question) => QuestionTile(
                                    question: question,
                                  ))
                              .toList(),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: CupertinoActivityIndicator(),
                      ))
              ],
              title: title,
            );
          },
        ),
      ),
    );
  }
}
