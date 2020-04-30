import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

class YesNoQuestionView extends StatefulWidget {
  static final YES = "yes";
  static final NO = "no";

  // Call back to set our answer
  final SymptomCheckerPageDelegate pageDelegate;

  // Model for our question
  final SymptomCheckerPageModel pageModel;

  const YesNoQuestionView(
      {Key key, @required this.pageDelegate, @required this.pageModel})
      : super(key: key);

  @override
  _YesNoQuestionViewState createState() => _YesNoQuestionViewState();
}

class _YesNoQuestionViewState extends State<YesNoQuestionView> {
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
                width: 200,
                child: Html(data: widget.pageModel.question.questionHtml)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    color: _selection == YesNoQuestionView.YES
                        ? Colors.green
                        : Colors.grey,
                    child: Text("Yes"),
                    onPressed: () {
                      setState(() {
                        _selection = YesNoQuestionView.YES;
                      });
                    }),
                SizedBox(width: 24),
                FlatButton(
                    color: _selection == YesNoQuestionView.NO
                        ? Colors.red
                        : Colors.grey,
                    child: Text("No"),
                    onPressed: () {
                      setState(() {
                        _selection = YesNoQuestionView.NO;
                      });
                    }),
              ],
            ),
            Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.pageModel.questionIndex > 0
                    ? FlatButton(
                        color: Colors.grey,
                        child: Text("Previous"),
                        onPressed: _previous)
                    : Container(),
                FlatButton(
                    color: Colors.grey,
                    child: Text("Next"),
                    onPressed: _selection != null ? _next : null)
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  void _next() {
    widget.pageDelegate.answerQuestion({_selection});
  }

  void _previous() {
    widget.pageDelegate.goBack();
  }
}
