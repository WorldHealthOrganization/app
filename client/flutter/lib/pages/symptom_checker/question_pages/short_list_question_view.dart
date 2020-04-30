import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

// A short list question supporting either single or multiple selection modes.
class ShortListQuestionView extends StatefulWidget {
  // Call back to set our answer
  final SymptomCheckerPageDelegate pageDelegate;
  final bool multipleSelection;

  // Model for our question
  final SymptomCheckerPageModel pageModel;

  const ShortListQuestionView(
      {Key key,
      @required this.pageDelegate,
      @required this.pageModel,
      @required this.multipleSelection})
      : super(key: key);

  @override
  _ShortListQuestionViewState createState() => _ShortListQuestionViewState();
}

class _ShortListQuestionViewState extends State<ShortListQuestionView> {
  String _singleSelection;
  Set<String> _multipleSelections = {};

  @override
  void initState() {
    super.initState();
    if (widget.pageModel.selectedAnswers.isNotEmpty) {
      if (widget.multipleSelection) {
        _multipleSelections = widget.pageModel.selectedAnswers;
      } else {
        _singleSelection = widget.pageModel.selectedAnswers.first;
      }
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
                width: 200,
                child: Html(data: widget.pageModel.question.questionHtml)),
            SizedBox(height: 24),
            ...widget.pageModel.question.answers.map(_buildAnswerRow).toList(),
            Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (widget.pageModel.questionIndex > 0)
                  FlatButton(
                      color: Colors.grey,
                      child: Text("Previous"),
                      onPressed: _previous),
                FlatButton(
                    color: Colors.grey,
                    child: Text("Next"),
                    onPressed: isComplete() ? _next : null),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerRow(SymptomCheckerAnswer answer) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
            color: Colors.white,
            child: Radio<String>(
                groupValue: _singleSelection == answer.id ? answer.id : "",
                value: answer.id,
                onChanged: _onSelection),
          ),
          Flexible(child: Html(data: answer.answerHtml))
        ]);
  }

  void _previous() {
    widget.pageDelegate.goBack();
  }

  void _next() {
    if (widget.multipleSelection) {
      widget.pageDelegate.answerQuestion(_multipleSelections);
    } else {
      widget.pageDelegate.answerQuestion({_singleSelection});
    }
  }

  bool isComplete() {
    return (widget.multipleSelection && _multipleSelections.isNotEmpty) ||
        (!widget.multipleSelection && _singleSelection != null);
  }

  void _onSelection(String answerId) {
    setState(() {
      _singleSelection = answerId;
    });
  }
}
