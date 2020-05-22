import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/components/forms.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/pages/symptom_checker/question_pages/previous_next_buttons.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';
import 'package:html/dom.dart' as dom;

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

class _ShortListQuestionViewState extends State<ShortListQuestionView>
    with AutomaticKeepAliveClientMixin {
  String _singleSelection;
  Set<String> _multipleSelections = {};
  bool _noneOfTheAboveSelected = false;

  // Prevents the widget's state from being lost when it is no longer the
  // current page in the PageView. Otherwise user selections would be lost when
  // pressing the back button.
  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    final answers = widget.pageModel.question.answers;
    final group = _allowsMultipleSelection
        ? PickOneOrMoreOptionGroup(
            items: [
              ...answers.map((a) => MultiSelectOptionItem(
                    title: a.title,
                    selected: _multipleSelections.contains(a.id),
                  )),
              // TODO: Localize
              MultiSelectOptionItem(
                  title: "None of the above", noneOfTheAbove: true),
            ],
            onPressed: (idx, sel) {
              setState(() {
                _multipleSelections.clear();
                if (sel.last.selected) {
                  _noneOfTheAboveSelected = true;
                } else {
                  _noneOfTheAboveSelected = false;
                  for (int i = 0; i < answers.length; i++) {
                    if (sel[i].selected) {
                      _multipleSelections.add(answers[i].id);
                    }
                  }
                }
              });
            },
          )
        : PickOneOptionGroup(
            items: widget.pageModel.question.answers
                .map((a) => OptionItem(
                      title: a.title,
                      selected: _singleSelection == a.id,
                    ))
                .toList(),
            onPressed: (idx, sel) {
              setState(() {
                _singleSelection = null;
                final idx = sel.indexWhere((e) => e.selected);
                if (idx >= 0) {
                  _singleSelection = answers[idx].id;
                } else {
                  _singleSelection = null;
                }
              });
            },
          );
    final TextStyle defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context));
    final TextStyle boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ThemedText(
                        widget.pageModel.question.title,
                        variant: TypographyVariant.h3,
                      ),
                      if (widget.pageModel.question.bodyHtml != null)
                        Html(
                          customEdgeInsets: (_) => EdgeInsets.zero,
                          data: widget.pageModel.question.bodyHtml,
                          defaultTextStyle: defaultTextStyle,
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case 'b':
                                  return baseStyle.merge(boldTextStyle);
                              }
                            }
                            return baseStyle.merge(defaultTextStyle);
                          },
                        )
                    ],
                  )),
              SizedBox(
                  height: widget.pageModel.question.bodyHtml != null ? 36 : 18),
              group,
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: NextButton(enableNext: _isComplete, onNext: _next)),
              SizedBox(height: 48),
            ],
          ),
        )),
      ],
    );
  }

  void _next() {
    if (_allowsMultipleSelection) {
      widget.pageDelegate.answerQuestion(_multipleSelections);
    } else {
      widget.pageDelegate.answerQuestion({_singleSelection});
    }
  }

  bool get _isComplete {
    return (_allowsMultipleSelection &&
            (_noneOfTheAboveSelected || _multipleSelections.isNotEmpty)) ||
        (!_allowsMultipleSelection && _singleSelection != null);
  }
}
