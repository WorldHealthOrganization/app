import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

class YesNoQuestionPage extends StatefulWidget {
  // Call back to set our answer
  final SymptomCheckerPageDelegate pageDelegate;

  // Model for our question
  final SymptomCheckerPageModel pageModel;

  const YesNoQuestionPage(
      {Key key, @required this.pageDelegate, @required this.pageModel})
      : super(key: key);

  @override
  _YesNoQuestionPageState createState() => _YesNoQuestionPageState();
}

class _YesNoQuestionPageState extends State<YesNoQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 64),
            Container(
              width: 200,
                child: Html(data: widget.pageModel.question.questionHtml)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    color: Colors.green,
                    child: Text("Yes"),
                    onPressed: () {
                      widget.pageDelegate.answerQuestion("Yes");
                    }),
                SizedBox(width: 24),
                FlatButton(
                    color: Colors.red,
                    child: Text("No"),
                    onPressed: () {
                      widget.pageDelegate.answerQuestion("No");
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
