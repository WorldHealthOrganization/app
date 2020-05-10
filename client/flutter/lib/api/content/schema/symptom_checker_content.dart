import 'package:who_app/api/content/content_bundle.dart';
import 'package:flutter/cupertino.dart';
import '../content_loading.dart';

/// Interpret a content bundle as symptom checker data.
/// Symptom checker data comprises a series of question and answers with metadata
/// and optional gating conditions determining which questions and answer options
/// are to be presented.
class SymptomCheckerContent extends ContentBase {
  List<SymptomCheckerQuestion> questions;

  static Future<SymptomCheckerContent> load(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "symptom_checker");
    return SymptomCheckerContent(bundle);
  }

  SymptomCheckerContent(ContentBundle bundle)
      : super(bundle, schemaName: "symptom_checker") {
    try {
      this.questions = bundle.contentItems.map(_questionFromContent).toList();
    } catch (err) {
      print("Error loading symptom checker data: $err");
      throw ContentBundleDataException();
    }
  }

  SymptomCheckerQuestion _questionFromContent(dynamic item) {
    SymptomCheckerQuestionType type;
    switch (item['type']) {
      case "single_selection":
        type = SymptomCheckerQuestionType.SingleSelection;
        break;
      case "multiple_selection":
        type = SymptomCheckerQuestionType.MultipleSelection;
        break;
      default:
        throw Exception("unreognized question type");
    }
    return SymptomCheckerQuestion(
        type: type,
        id: item['id'],
        questionHtml: item['question_html'],
        displayCondition: item['display_condition'],
        imageName: item['image_name'],
        answers: _answersFromContent(item));
  }

  List<SymptomCheckerAnswer> _answersFromContent(dynamic item) {
    var answers = item['answers'];
    if (answers == null) {
      return null;
    }
    return List<SymptomCheckerAnswer>.from(answers.map(_answerFromContent));
  }

  SymptomCheckerAnswer _answerFromContent(dynamic item) {
    return SymptomCheckerAnswer(
      id: item['id'],
      bodyHtml: item['body_html'],
      iconName: item['icon_name'],
    );
  }
}

enum SymptomCheckerQuestionType {
  /// A question with a list of answers intended to be presented together in
  /// which a single selection is required.
  SingleSelection,

  /// A question with a list of answers intended to be presented together in
  /// which zero or more selections are allowed.
  MultipleSelection,
}

/// SymptomChecker ('symptom_checker' schema) question items including question and
/// answer data, metadata, and optional gating conditions used in presentation.
class SymptomCheckerQuestion {
  final SymptomCheckerQuestionType type;

  /// A globally unique id for the question.
  final String id;

  /// The question.
  final String questionHtml;

  /// An optional image to be displayed with the question.
  final String imageName;

  /// An expression indicating whether the question should be presented.
  final String displayCondition;

  /// The list of possible answers.
  final List<SymptomCheckerAnswer> answers;

  bool get allowsMultipleSelection {
    switch (type) {
      case SymptomCheckerQuestionType.SingleSelection:
        return false;
      case SymptomCheckerQuestionType.MultipleSelection:
        return true;
    }
    throw Exception("should be unreachable");
  }

  SymptomCheckerQuestion({
    @required this.type,
    @required this.id,
    @required this.questionHtml,
    @required this.imageName,
    @required this.displayCondition,
    this.answers,
  });
}

class SymptomCheckerAnswer {
  /// An id for the answer that is unique within its question context.
  final String id;

  /// An expression indicating whether the question should be presented.
  final String displayCondition;

  /// The answer
  final String bodyHtml;

  /// An icon to display with the answer
  final String iconName;

  SymptomCheckerAnswer({
    @required this.id,
    this.displayCondition,
    @required this.bodyHtml,
    this.iconName,
  });
}
