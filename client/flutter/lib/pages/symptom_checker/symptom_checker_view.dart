import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/pages/symptom_checker/question_pages/short_list_question_view.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

/// This view is the container for the series of symptom checker questions.
class SymptomCheckerView extends StatefulWidget {
  @override
  _SymptomCheckerViewState createState() => _SymptomCheckerViewState();
}

class _SymptomCheckerViewState extends State<SymptomCheckerView>
    implements SymptomCheckerPageDelegate {
  final PageController _controller = PageController();
  SymptomCheckerModel _model;
  List<Widget> _pages;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _initModel();
    _modelChanged();
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: Text("Symptom Checker"),
      ),
      child: Container(child: _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    if (_model == null) {
      return _buildMessage("Loading...", loading: true);
    }
    if (_model.isFatalError) {
      return _buildMessage(
          "Unfortunately the symptom checker encountered an error.  If this is an emergency, please call for help immediately.",
          loading: false);
    }
    return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _pages ?? []);
  }

  Widget _viewForPageModel(SymptomCheckerPageModel model) {
    switch (model.question.type) {
      case SymptomCheckerQuestionType.SingleSelection:
        return ShortListQuestionView(pageDelegate: this, pageModel: model);
      case SymptomCheckerQuestionType.MultipleSelection:
        return ShortListQuestionView(pageDelegate: this, pageModel: model);
    }
    throw Exception("Unsupported");
  }

  Widget _buildMessage(String text, {bool loading = false}) {
    return Column(
      children: <Widget>[
        Spacer(),
        Center(
            child: Column(
          children: <Widget>[
            Text(text),
            if (loading)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CupertinoActivityIndicator(),
              ),
          ],
        )),
        Spacer(flex: 3),
      ],
    );
  }

  void _modelChanged() {
    setState(() {
      _pages = _model.pages.map(_viewForPageModel).toList();
    });
    _nextPage();
  }

  void _nextPage() {
    if (!_controller.hasClients) {
      return;
    }
    if (_controller.page < _model.pages.length) {
      _controller.animateToPage(_model.pages.length - 1,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  Future<void> _previousPage() => _controller.previousPage(
      duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

  /// Receive answers from the page and update the model.
  @override
  void answerQuestion(Set<String> answerIds) {
    _model.answerQuestion(answerIds);
    if (!_model.isFatalError && _model.results != null) {
      Navigator.of(context)
          .pushNamed('/symptom-checker-results', arguments: _model);
      return;
    }
  }

  /// Receive back indication from the page and update the model.
  @override
  void goBack() async {
    await _previousPage();
    _model.previousQuestion();
  }
}
