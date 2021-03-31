import 'package:flutter/material.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/api/display_conditions.dart';

/// Represents a series of symptom checker pages.
/// Notifies the listener on page changes or change of status including completion
/// of the series or indication that the user should seek medical attention.
class SymptomCheckerModel with ChangeNotifier {
  final SymptomCheckerContent _content;
  final LogicContext _logicContext;

  /// Create the symptom checker model with content from a content bundle.
  SymptomCheckerModel(this._content, this._logicContext) {
    // Add the first page
    pages.add(SymptomCheckerPageModel(
        question: _content.questions.first,
        questionCount: _content.questions.length,
        questionIndex: 0));
  }

  /// Non-null when the question series is complete and ready for analysis.
  List<SymptomCheckerResult> results;

  /// True if the symptom checker cannot continue functioning.
  bool isFatalError = false;

  /// Get the current list of one or more pages including the initial question
  /// page and any subsequently presented question pages.
  List<SymptomCheckerPageModel> pages = [];

  /// Get the current page (the last page in the answered pages).
  SymptomCheckerPageModel get currentPage {
    return pages.last;
  }

  /// Set the answer for the current page, advancing to the next question if
  /// needed. If additional questions remain the next page will be added to
  /// the pages list. If the series is complete the results will be set.
  /// In both cases the change notifier will fire to indicate the update.
  void answerQuestion(Set<String> answerIds) {
    isFatalError = true;
    try {
      results = _answerQuestionImpl(answerIds);
      isFatalError = false;
    } catch (e) {
      print(e);
      // Do NOT log these errors to analytics.
      isFatalError = true;
    }
    notifyListeners();
  }

  List<SymptomCheckerResult> _answerQuestionImpl(Set<String> answerIds) {
    pages[pages.length - 1] = currentPage.withAnswers(answerIds);

    var nextPageFound = false;
    final logic = SymptomLogic();
    for (var i = pages[pages.length - 1].questionIndex + 1;
        !nextPageFound && i < _content.questions.length;
        i++) {
      nextPageFound = logic.evaluateCondition(
          condition: _content.questions[i].displayCondition,
          previousPages: pages,
          context: _logicContext);
      if (nextPageFound) {
        pages.add(SymptomCheckerPageModel(
            question: _content.questions[i],
            questionCount: _content.questions.length,
            questionIndex: i));
      }
    }
    if (nextPageFound) {
      return null;
    }

    return List<SymptomCheckerResult>.unmodifiable(_content.results.where((r) =>
        logic.evaluateCondition(
            condition: r.displayCondition,
            previousPages: pages,
            context: _logicContext)));
  }

  /// Indicate that the user has driven the UI back to the previous page or
  /// wishes to drive the UI back to the previous page. The model will truncate
  /// the last page and the change notifier will fire.
  void previousQuestion() {
    pages.removeLast();
    notifyListeners();
  }
}

/// Represents a single page in the series of question pages, possibly with
/// a selected answer.
class SymptomCheckerPageModel {
  /// The question for this page.
  final SymptomCheckerQuestion question;

  /// The total number of questions
  final int questionCount;

  /// The index of this question
  final int questionIndex;

  /// The set of selected answers or an empty set if no selection has been made.
  final Set<String> selectedAnswers;

  SymptomCheckerPageModel({
    @required this.question,
    @required this.questionCount,
    @required this.questionIndex,
    this.selectedAnswers = const {},
  });

  SymptomCheckerPageModel withAnswers(Set<String> answerIds) {
    return SymptomCheckerPageModel(
        question: question,
        selectedAnswers: answerIds,
        questionCount: questionCount,
        questionIndex: questionIndex);
  }
}

/// Interface for the UI that hosts a symptom checker page to receive user actions.
/// The UI applies these results to the model and observe the changes.
abstract class SymptomCheckerPageDelegate {
  // Provide answers for the current page.
  void answerQuestion(Set<String> answerIds);

  // Indicate that the user wishes to go back to the previous page using an
  // affordance on the page.
  void goBack();
}
