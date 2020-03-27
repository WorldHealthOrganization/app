import 'package:flutter/cupertino.dart';

/// This is just a *placeholder* for the dynamic content.
class QuestionData {
  static Future<List<QuestionItem>> questions() async {
    return [
      QuestionItem(
          title:
          "What are coronaviruses, <b>what is COVID-19</b>, and how is it related to SARS?",
          body: """
              <h2>What are the symptoms of COVID-19?</h2>
              The most common symptoms of COVID-19 are:
              <ul>
              <li>🤒 fever</li>
              <li>tiredness</li>
              <li>cough</li>
              </ul>
              """),
      QuestionItem(
          title:
          "What are coronaviruses, <b>what is COVID-19</b>, and how is it related to SARS? 2",
          body: """
              <h2>What are the symptoms of COVID-19?</h2>
              The most common symptoms of COVID-19 are:
              <ul>
              <li>🤒 fever</li>
              <li>tiredness</li>
              <li>cough</li>
              </ul>
              """),
      QuestionItem(
          title:
              "What are coronaviruses, <b>what is COVID-19</b>, and how is it related to SARS? 3",
          body: """
              <h2>What are the symptoms of COVID-19?</h2>
              The most common symptoms of COVID-19 are:
              <ul>
              <li>🤒 fever</li>
              <li>tiredness</li>
              <li>cough</li>
              </ul>
              """),
    ];
  }
}

class QuestionItem {
  String title;
  String body;

  QuestionItem({@required this.title, @required this.body});
}
