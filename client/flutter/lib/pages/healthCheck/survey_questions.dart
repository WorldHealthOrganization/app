class SurveyQuestion {
  String question;
  QuestionTypes type;
  List answers;
  String condition;

  SurveyQuestion(this.question, this.type, {this.answers, this.condition});
}

enum QuestionTypes { checkbox, text }
