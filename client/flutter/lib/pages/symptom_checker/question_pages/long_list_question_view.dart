import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/pages/symptom_checker/question_pages/previous_next_buttons.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

// A long list question supporting a single selection.
class LongListQuestionView extends StatefulWidget {
  // Call back to set our answer
  final SymptomCheckerPageDelegate pageDelegate;

  // Model for our question
  final SymptomCheckerPageModel pageModel;

  const LongListQuestionView({
    Key key,
    @required this.pageDelegate,
    @required this.pageModel,
  }) : super(key: key);

  @override
  _LongListQuestionViewState createState() => _LongListQuestionViewState();
}

class _LongListQuestionViewState extends State<LongListQuestionView> {
  String _selection;

  @override
  void initState() {
    super.initState();
    if (widget.pageModel.selectedAnswers.isNotEmpty) {
      _selection = widget.pageModel.selectedAnswers.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
                width: 300,
                child: Html(data: widget.pageModel.question.questionHtml)),
            SizedBox(height: 24),
            Flexible(
              flex: 3,
              child: ListView.builder(
                  itemCount: widget.pageModel.question.answers.length,
                  itemBuilder: _buildAnswerRowForIndex),
            ),
            SizedBox(height: 24),
            PreviousNextButtons(
                showPrevious: widget.pageModel.questionIndex > 0,
                enableNext: _selection != null,
                onPrevious: _previous,
                onNext: _next),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerRowForIndex(BuildContext context, int index) {
    return _buildAnswerRow(widget.pageModel.question.answers[index], index);
  }

  Widget _buildAnswerRow(SymptomCheckerAnswer answer, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _selected(answer.id);
      },
      child: Material(
        color: index % 2 == 0 ? Colors.grey : Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio<String>(
                  groupValue: _selection, value: answer.id, onChanged: (_) {}),
              Flexible(child: Html(data: answer.bodyHtml))
            ]),
      ),
    );
  }

  void _previous() {
    widget.pageDelegate.goBack();
  }

  void _next() {
    widget.pageDelegate.answerQuestion({_selection});
  }

  void _selected(String answerId) {
    _selection = answerId;
    setState(() {});
  }
}
