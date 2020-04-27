import 'package:flutter/material.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';

/// Represents a series of symptom checker pages.
/// Notifies the listener on page changes or change of status including completion
/// of the series or indication that the user should seek medical attention.
class SymptomCheckerModel with ChangeNotifier {
  final SymptomCheckerContent _content;

  /// Create the symptom checker model with content from a content bundle.
  SymptomCheckerModel(this._content) {
    // Add the first page
    pages.add(SymptomCheckerPageModel(question: _content.questions.first));
  }

  /// True when the question series is complete and ready for analysis.
  bool isComplete = false;

  /// True if the user should be instructed to seek medical attention immediately.
  /// If this flag is set in response to a question the series should be considered
  /// as completed and appropriate instructions should be provided.
  bool seekMedicalAttention = false;

  /// Get the current list of one or more pages including the initial question
  /// page and any subsequently presented question pages.
  List<SymptomCheckerPageModel> pages = [];

  /// Get the current page (the last page in the answered pages).
  SymptomCheckerPageModel get currentPage {
    return pages.last;
  }

  /// Set the answer for the current page, advancing as needed.
  /// If additional questions remain the next page will be added to the the
  /// pages list. If the series is complete the isComplete flag will be set.
  /// In both cases the change notifier will fire to indicate the update.
  void answerQuestion(String answerId) {
    pages[pages.length - 1] = SymptomCheckerPageModel(
        question: currentPage.question, selectedAnswerId: answerId);
    // TODO: Toy implementation - always add the next page if it exists
    if (_content.questions.length > pages.length) {
      pages.add(
          SymptomCheckerPageModel(question: _content.questions[pages.length]));
    }
    // TODO: Toy implementation - assume all pages are shown
    if (_content.questions.length == pages.length &&
        currentPage.selectedAnswerId != null) {
      isComplete = true;
    }
    notifyListeners();
  }

  /// Indicate that the user has driven the UI back to the previous page or
  /// wishes to drive the UI back to the previous page. The model will truncate
  /// the last page and the change notifier will fire.
  void goBack() {
    pages.removeLast();
    notifyListeners();
  }
}

/// Represents a single page in the series of question pages, possibly with
/// a selected answer.
class SymptomCheckerPageModel {
  // The question for this page.
  final SymptomCheckerQuestion question;

  // The selected answer, if any, or null if no selection has been made.
  final String selectedAnswerId;

  SymptomCheckerPageModel({@required this.question, this.selectedAnswerId});
}

/// Interface for the UI that hosts a symptom checker page to receive user actions.
/// The UI applies these results to the model and observe the changes.
abstract class SymptomCheckerPageDelegate {
  // Provide the answer for the current page.
  void answerQuestion(String answerId);

  // Indicate that the user wishes to go back to the previous page using an
  // affordance on the page.
  void goBack();
}
