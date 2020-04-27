import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/pages/symptom_checker/question_pages/yes_no_question_page.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

/// This page is the container for the series of symptom checker questions.
class SymptomCheckerPage extends StatefulWidget {
  @override
  _SymptomCheckerPageState createState() => _SymptomCheckerPageState();
}

class _SymptomCheckerPageState extends State<SymptomCheckerPage>
    implements SymptomCheckerPageDelegate {
  SymptomCheckerModel _model;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _initModel();
  }

  Future<void> _initModel() async {
    if (_model != null) {
      return;
    }
    // TODO: Reduce this boilerplate
    Locale locale = Localizations.localeOf(context);
    try {
      var content = await SymptomCheckerContent.load(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, content);
      _model = SymptomCheckerModel(content);
    } catch (err) {
      print("Error loading content: $err");
    }
    _model.addListener(_modelChanged);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Present the model using a PageView or or other view allowing for
    // TODO: page transitions and appropriate back gestures if allowed.
    // TODO: Map the list of page models (or at least the current page) by their
    // TODO: page model question type field to the desired implementation Widgets.
    if (_model == null) {
      return Center(child: Text("loading..."));
    }
    if (_model.isComplete) {
      return Center(child: Text("Complete!"));
    }
    if (_model.seekMedicalAttention) {
      return Center(child: Text("Seek Medial Attention!"));
    }
    // TODO: This is just a toy implementation - see above.
    // TODO: Assuming only yes/no question types here.
    return YesNoQuestionPage(pageDelegate: this, pageModel: _model.currentPage);
  }

  void _modelChanged() {
    print("model changed");
    setState(() {});
  }

  /// Receive answers from the page and update the model.
  @override
  void answerQuestion(String answerId) {
    _model.answerQuestion(answerId);
  }

  /// Receive back indication from the page and update the model.
  @override
  void goBack() {
    _model.goBack();
  }
}
