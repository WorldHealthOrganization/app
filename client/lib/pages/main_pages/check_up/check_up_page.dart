import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';

import 'check_up_intro_page.dart';
import 'check_up_poster_page.dart';

class CheckUpPage extends ContentWidget<SymptomCheckerContent> {
  CheckUpPage({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(BuildContext context, SymptomCheckerContent content,
      LogicContext logicContext) {
    if (content == null || logicContext == null) {
      return PageScaffold(
        showBackButton: false,
        title: 'Check-Up',
        body: <Widget>[SliverSafeArea(sliver: LoadingIndicator())],
      );
    }
    return content.poster != null
        ? CheckUpPosterPage(getContent().poster, logicContext)
        : CheckUpIntroPage();
  }

  @override
  SymptomCheckerContent getContent() => dataSource.symptomChecker;
}
