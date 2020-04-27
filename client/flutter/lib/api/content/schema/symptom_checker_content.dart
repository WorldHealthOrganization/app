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
    // Sigh.
    SymptomCheckerQuestionType type = SymptomCheckerQuestionType.values
        .firstWhere((e) =>
            e.toString() == "${SymptomCheckerQuestionType}.${item['type']}");
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
    return answers.map(_answerFromContent).toList();
  }

  SymptomCheckerAnswer _answerFromContent(dynamic item) {
    return SymptomCheckerAnswer(
        id: item['id'], answerHtml: item['answer_html']);
  }
}

enum SymptomCheckerQuestionType {
  /// A yes or no question.
  YesNo,

  /// A question with a short list of answers intended to be presented together in
  /// which a single selection is allowed.
  ShortListSingleSelection,

  /// A question with a short list of answers intended to be presented together in
  /// which multiple selections are allowed.
  ShortListMultipleSelection,

  /// A question with a lengthy list of answers intended to be presented in a list
  /// in which a single selection is allowed.
  LongListSingleSelection,
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

  SymptomCheckerQuestion(
      {@required this.type,
      @required this.id,
      @required this.questionHtml,
      @required this.imageName,
      @required this.displayCondition,
      this.answers});
}

class SymptomCheckerAnswer {
  /// An id for the question that is unique within its question context.
  final String id;

  /// An expression indicating whether the question should be presented.
  final String displayCondition;

  /// The answer
  final String answerHtml;

  SymptomCheckerAnswer(
      {@required this.id, this.displayCondition, @required this.answerHtml});
}
