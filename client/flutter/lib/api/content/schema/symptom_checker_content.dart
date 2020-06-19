import 'package:who_app/api/content/content_bundle.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/conditional_content.dart';
import 'package:who_app/api/linking.dart';
import '../content_loading.dart';

/// Interpret a content bundle as symptom checker data.
/// Symptom checker data comprises a series of question and answers with metadata
/// and optional gating conditions determining which questions and answer options
/// are to be presented.
class SymptomCheckerContent extends ContentBase {
  List<SymptomCheckerQuestion> questions;
  List<SymptomCheckerResult> results;
  Map<String, SymptomCheckerResultCard> cards;

  static Future<SymptomCheckerContent> load(Locale locale) async {
    var bundle = await ContentLoading().load(locale, "symptom_checker");
    return SymptomCheckerContent(bundle);
  }

  SymptomCheckerContent(ContentBundle bundle)
      : super(bundle, schemaName: "symptom_checker") {
    try {
      this.questions = bundle.contentItems.map(_questionFromContent).toList();
      this.cards = Map<String, SymptomCheckerResultCard>.fromIterable(
          bundle.contentCards.map(_cardFromContent),
          key: (v) => v.id,
          value: (v) => v);
      this.results = bundle.contentResults.map(_resultFromContent).toList();
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
        title: item['title'],
        bodyHtml: item['body_html'],
        displayCondition: item['display_condition'],
        imageName: item['image_name'],
        answers: _answersFromContent(item));
  }

  SymptomCheckerResult _resultFromContent(dynamic item) {
    SymptomCheckerResultSeverity severity;
    if (item['severity'] != null) {
      switch (item['severity']) {
        case "covid19_symptoms":
          severity = SymptomCheckerResultSeverity.COVID19Symptoms;
          break;
        case "some_symptoms":
          severity = SymptomCheckerResultSeverity.SomeSymptoms;
          break;
        case "none":
          severity = SymptomCheckerResultSeverity.None;
          break;
        case "emergency":
          severity = SymptomCheckerResultSeverity.Emergency;
          break;
        default:
          throw Exception("unrecognized result severity");
      }
    }
    return SymptomCheckerResult(
        title: item['title'],
        severity: severity,
        id: item['id'],
        displayCondition: item['display_condition'],
        cards: _cardsFromIds(item['cards']));
  }

  List<SymptomCheckerResultCard> _cardsFromIds(dynamic cardIds) {
    if (cardIds == null) {
      return [];
    }
    return List<SymptomCheckerResultCard>.from(cardIds.map((id) => cards[id]));
  }

  SymptomCheckerResultCard _cardFromContent(dynamic item) {
    return SymptomCheckerResultCard(
      id: item['id'],
      title: item['title'],
      bodyHtml: item['body_html'],
      iconName: item['icon_name'],
      titleLink: item['href'] != null ? RouteLink.fromUri(item['href']) : null,
      links: item['links'] == null
          ? null
          : List<SymptomCheckerResultLink>.from(item['links'].map((link) =>
              SymptomCheckerResultLink(
                  title: link['title'],
                  link: RouteLink.fromUri(link['href'])))),
    );
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
      title: item['title'],
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
  final String title;

  final String bodyHtml;

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
    @required this.title,
    this.bodyHtml,
    this.imageName,
    @required this.displayCondition,
    this.answers,
  });
}

enum SymptomCheckerResultSeverity {
  None,
  SomeSymptoms,
  COVID19Symptoms,
  Emergency,
}

class SymptomCheckerResult {
  /// A globally unique id for the result.
  final String id;

  /// The summary/title.
  final String title;

  /// The summary/title.
  final SymptomCheckerResultSeverity severity;

  /// An expression indicating whether the question should be presented.
  final String displayCondition;

  /// The list of possible answers.
  final List<SymptomCheckerResultCard> cards;

  SymptomCheckerResult({
    @required this.id,
    this.title,
    @required this.displayCondition,
    this.severity,
    this.cards,
  });
}

class SymptomCheckerResultCard {
  /// The title
  final String id;

  /// The title
  final String title;

  /// The answer
  final String bodyHtml;

  /// An icon to display with the answer
  final String iconName;

  final RouteLink titleLink;

  final List<SymptomCheckerResultLink> links;

  SymptomCheckerResultCard({
    @required this.id,
    @required this.title,
    this.bodyHtml,
    this.iconName,
    this.titleLink,
    this.links,
  });
}

class SymptomCheckerResultLink {
  final String title;

  final RouteLink link;

  SymptomCheckerResultLink({
    @required this.title,
    @required this.link,
  });
}

class SymptomCheckerAnswer with ConditionalItem {
  /// An id for the answer that is unique within its question context.
  final String id;

  /// An expression indicating whether the question should be presented.
  final String displayCondition;

  /// The answer
  final String title;

  /// An icon to display with the answer
  final String iconName;

  SymptomCheckerAnswer({
    @required this.id,
    this.displayCondition,
    @required this.title,
    this.iconName,
  });
}
