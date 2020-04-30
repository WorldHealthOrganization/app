import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_view.dart';

/// This page introduces the symptom checker and presents the symptom checker view
/// to display the series of questions.
class SymptomCheckerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Spacer(),
          Text("This is the symptom checker introductory text."),
          SizedBox(height: 16),
          FlatButton(
              color: Colors.grey,
              child: Text("Begin the questions"),
              onPressed: () {
                return Navigator.of(context).push(
                    CupertinoPageRoute(builder: (_) => SymptomCheckerView()));
              }),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
