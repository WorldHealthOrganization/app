import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/pages/symptom_checker/question_pages/previous_next_buttons.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

// A short list question supporting either single or multiple selection modes.
class ShortListQuestionView extends StatefulWidget {
  // Call back to set our answer
  final SymptomCheckerPageDelegate pageDelegate;

  // Model for our question
  final SymptomCheckerPageModel pageModel;

  const ShortListQuestionView({
    Key key,
    @required this.pageDelegate,
    @required this.pageModel,
  }) : super(key: key);

  @override
  _ShortListQuestionViewState createState() => _ShortListQuestionViewState();
}

class _ShortListQuestionViewState extends State<ShortListQuestionView> {
  String _singleSelection;
  Set<String> _multipleSelections = {};

  bool get _allowsMultipleSelection {
    return widget.pageModel.question.allowsMultipleSelection;
  }

  @override
  void initState() {
    super.initState();
    if (widget.pageModel.selectedAnswers.isNotEmpty) {
      if (_allowsMultipleSelection) {
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
                width: 300,
                child: Html(data: widget.pageModel.question.questionHtml)),
            SizedBox(height: 24),
            ...widget.pageModel.question.answers.map(_buildAnswerRow).toList(),
            Spacer(flex: 3),
            PreviousNextButtons(
                showPrevious: widget.pageModel.questionIndex > 0,
                enableNext: _isComplete,
                onPrevious: _previous,
                onNext: _next),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerRow(SymptomCheckerAnswer answer) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _selected(answer.id);
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (answer.iconName != null)
              SvgPicture.asset("assets/svg/${answer.iconName}.svg", height: 24),
            Material(
              color: Colors.white,
              child: _allowsMultipleSelection
                  ? Checkbox(
                      value: _multipleSelections.contains(answer.id),
                      onChanged: (_) {},
                    )
                  : Radio<String>(
                      groupValue: _singleSelection,
                      value: answer.id,
                      onChanged: (_) {},
                    ),
            ),
            Flexible(child: Html(data: answer.bodyHtml))
          ]),
    );
  }

  void _previous() {
    widget.pageDelegate.goBack();
  }

  void _next() {
    if (_allowsMultipleSelection) {
      widget.pageDelegate.answerQuestion(_multipleSelections);
    } else {
      widget.pageDelegate.answerQuestion({_singleSelection});
    }
  }

  bool get _isComplete {
    return (_allowsMultipleSelection && _multipleSelections.isNotEmpty) ||
        (!_allowsMultipleSelection && _singleSelection != null);
  }

  void _selected(String answerId) {
    if (_allowsMultipleSelection) {
      // toggle
      if (_multipleSelections.contains(answerId)) {
        _multipleSelections.remove(answerId);
      } else {
        _multipleSelections.add(answerId);
      }
    } else {
      _singleSelection = answerId;
    }
    setState(() {});
  }
}
