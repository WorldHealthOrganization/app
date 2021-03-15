import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/api/location_provider.dart';
import 'package:who_app/api/place/place.dart';
import 'package:who_app/api/place/place_prediction.dart';
import 'package:who_app/api/place/place_service.dart';
import 'package:who_app/components/forms.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/pages/symptom_checker/question_pages/next_button.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';
import 'package:html/dom.dart' as dom;

/// A question which displays an autocompleting location text field.
class LocationQuestionView extends StatefulWidget {
  /// Call back to set our answer
  final SymptomCheckerPageDelegate pageDelegate;

  /// Model for our question
  final SymptomCheckerPageModel pageModel;

  final LocationProvider locationProvider;
  final PlaceService placeService;

  const LocationQuestionView(
      {Key key,
      @required this.pageDelegate,
      @required this.pageModel,
      @required this.placeService,
      @required this.locationProvider})
      : super(key: key);

  @override
  _LocationQuestionViewState createState() => _LocationQuestionViewState();
}

class _LocationQuestionViewState extends State<LocationQuestionView>
    with AutomaticKeepAliveClientMixin {
  List<PlacePrediction> _predictions;
  PlacePrediction _selectedPrediction;
  final _textController = TextEditingController();

  /// A token passed to the Places API so that multiple autocomplete query
  /// requests can be grouped together into one billable event.
  String _autocompleteSessionToken;

  /// Prevents the widget's state from being lost when it is no longer the
  /// current page in the PageView. Otherwise user selections would be lost when
  /// pressing the back button.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    var savedLocation = widget.locationProvider.getLocation();
    if (widget.pageModel.selectedAnswers.length == 2) {
      var location = widget.pageModel.selectedAnswers.elementAt(0);
      var placeID = widget.pageModel.selectedAnswers.elementAt(1);
      _selectedPrediction = PlacePrediction(location, placeID);
    } else if (savedLocation != null) {
      _selectedPrediction =
          PlacePrediction(savedLocation.description, savedLocation.id);
    }
    _predictions = [];
    _autocompleteSessionToken = UniqueKey().toString();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context));
    final boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);

    if (_textController.text.isEmpty) {
      _textController.text = _selectedPrediction?.displayText;
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ThemedText(
                        widget.pageModel.question.title,
                        variant: TypographyVariant.h3,
                      ),
                      if (widget.pageModel.question.bodyHtml != null)
                        Html(
                          customEdgeInsets: (_) => EdgeInsets.zero,
                          data: widget.pageModel.question.bodyHtml,
                          defaultTextStyle: defaultTextStyle,
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case 'b':
                                  return baseStyle.merge(boldTextStyle);
                              }
                            }
                            return baseStyle.merge(defaultTextStyle);
                          },
                        )
                    ],
                  )),
              SizedBox(
                  height: widget.pageModel.question.bodyHtml != null ? 36 : 18),
              // TODO: Localize
              TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      suffixIcon: IconButton(
                        onPressed: _clearTextField,
                        icon: Icon(Icons.clear),
                      )),
                  onChanged: (String value) async {
                    _onTextFieldChanged(value);
                  }),
              _buildAutocompleteList(),
              SizedBox(height: _predictions.isEmpty ? 20 : 8),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: NextButton(enabled: _isComplete, onNext: _next)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: PageButton(CupertinoColors.white, 'Skip', _skip,
                      crossAxisAlignment: CrossAxisAlignment.center)),
              SizedBox(height: 48),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildAutocompleteList() {
    // Make the list view collapsible so that it doesn't show when we have
    // no predictions to display.
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: CupertinoScrollbar(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _predictions.length,
                    itemBuilder: _itemBuilder))),
        height: _predictions.isEmpty ? 0 : 240);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var selectedPrediction = _predictions[index];
    return ToggleOption(
        title: selectedPrediction.displayText,
        color: CupertinoColors.white,
        value: false,
        onPressed: () => _selectPrediction(selectedPrediction));
  }

  void _selectPrediction(PlacePrediction prediction) {
    _textController.text = prediction?.displayText;
    setState(() {
      _selectedPrediction = prediction;
      _predictions.clear();
      FocusScope.of(context).unfocus();
    });
  }

  /// Future used to synchronize autocomplete requests.
  Future<List<PlacePrediction>> _lastAutocompleteRequest = Future.value();

  void _onTextFieldChanged(String text) async {
    _selectedPrediction = null;
    var newPredictions = <PlacePrediction>[];
    if (text.isNotEmpty) {
      _lastAutocompleteRequest = widget.placeService.getAutocompleteSuggestions(
          partialAddress: text, sessionToken: _autocompleteSessionToken);
      var suggestions = await _lastAutocompleteRequest;
      newPredictions = suggestions
          .map((suggestion) =>
              PlacePrediction(suggestion.displayText, suggestion.placeID))
          .toList();
    } else {
      // clear list view
      await _lastAutocompleteRequest;
      newPredictions = [];
    }
    setState(() {
      _predictions = newPredictions;
    });
  }

  void _clearTextField() {
    _textController.clear();
    _onTextFieldChanged('');
  }

  void _next() {
    FocusScope.of(context).unfocus();
    var newPlace = Place(
        latitude: null,
        longitude: null,
        description: _selectedPrediction.displayText,
        id: _selectedPrediction.placeID);
    widget.locationProvider.saveLocationLocal(newPlace);
    if (_selectedPrediction != null) {
      widget.pageDelegate.answerQuestion(
          {_selectedPrediction.displayText, _selectedPrediction.placeID});

      // Update the session token if we have a selected location because we may
      // issue a "place details" request on the next page if the user consents
      // to sharing their location. The details request causes autocomplete
      // billing to revert to per-request if we reuse an old token.
      _autocompleteSessionToken = UniqueKey().toString();
    } else {
      widget.pageDelegate.answerQuestion({});
    }
  }

  void _skip() {
    _selectedPrediction = null;
    widget.pageDelegate.answerQuestion({});
  }

  bool get _isComplete {
    // This question is optional so let the user proceed if they've left the
    // text field blank. However, if they've typed something, make sure they've
    // selected an autocomplete prediction to prevent unvalidated input.
    return _selectedPrediction != null;
  }
}
