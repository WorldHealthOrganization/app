import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/api/content/content_loading.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/symptom_checker/question_pages/short_list_question_view.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

/// This view is the container for the series of symptom checker questions.
class SymptomCheckerView extends StatefulWidget {
  final ContentService contentService;

  const SymptomCheckerView({Key key, @required this.contentService})
      : super(key: key);

  @override
  _SymptomCheckerViewState createState() => _SymptomCheckerViewState();
}

class _SymptomCheckerViewState extends State<SymptomCheckerView>
    implements SymptomCheckerPageDelegate {
  final PageController _controller = PageController();
  SymptomCheckerModel _model;
  List<Widget> _pages;
  bool inTransition = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _initModel();
    _modelChanged();
  }

  // Unlike other content-based widgets, the symptom checker
  // will not dynamically react to new content.
  Future<void> _initModel() async {
    if (_model != null) {
      return;
    }
    // TODO: Reduce this boilerplate
    Locale locale = Localizations.localeOf(context);
    try {
      final logicContext = await LogicContext.generate();
      final store =
          ContentStore(service: widget.contentService, locale: locale);
      await store.update();
      var content = store.symptomChecker;
      await Dialogs.showUpgradeDialogIfNeededFor(context, content);
      _model = SymptomCheckerModel(content, logicContext);
    } catch (err) {
      print("Error loading content: $err");
    }
    _model.addListener(_modelChanged);
    if (!mounted) return;
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    // If the page controller hasn't been built yet then we're on the first page
    if (_controller.hasClients == false) return true;

    if (inTransition) return false;

    if (_controller.page == 0) {
      return true;
    } else {
      await goBack();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        color: Constants.backgroundColor,
        child: Column(
          children: <Widget>[
            PageHeader(
              inSliver: false,
              title: 'Check-Up',
              appBarColor: Constants.backgroundColor,
              trailing: FlatButton(
                padding: EdgeInsets.zero,
                child: ThemedText(
                  "Cancel",
                  variant: TypographyVariant.button,
                  style: TextStyle(color: Constants.whoBackgroundBlueColor),
                ),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ),
            Expanded(child: _buildPage(context)),
          ],
        ),
      ),
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
    if (_model == null) {
      return;
    }
    setState(() {
      _pages = _model.pages.map(_viewForPageModel).toList();
    });
    _nextPage();
  }

  void _nextPage() async {
    if (!_controller.hasClients) {
      return;
    }
    if (_controller.page < _model.pages.length) {
      inTransition = true;
      await _controller.animateToPage(_model.pages.length - 1,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      inTransition = false;
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
  Future<void> goBack() async {
    inTransition = true;
    await _previousPage();
    inTransition = false;
    _model.previousQuestion();
  }
}
