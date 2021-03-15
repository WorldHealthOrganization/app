import 'package:flutter/cupertino.dart';
import 'package:who_app/api/place/place_service.dart';
import 'package:who_app/pages/symptom_checker/question_pages/short_list_question_view.dart';

class LocationSharingQuestionView extends ShortListQuestionView {
  final PlaceService placeService;

  const LocationSharingQuestionView(
      {Key key,
      @required pageDelegate,
      @required pageModel,
      @required this.placeService})
      : super(key: key, pageDelegate: pageDelegate, pageModel: pageModel);

  @override
  _LocationSharingQuestionViewState createState() =>
      _LocationSharingQuestionViewState();
}

class _LocationSharingQuestionViewState extends ShortListQuestionViewState {
  @override
  void next() {
    // TODO:
    //  * retrieve stored location
    //  * issue Places API details request
    //  * sync results to Firestore
    super.next();
  }
}
