import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/protect_yourself_card.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class ProtectYourself extends ContentWidget<FactContent> {
  ProtectYourself({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  final whoBlue = Color(0xFF3D8BCC);
  final header = TextStyle(
      color: CupertinoColors.black, fontSize: 24, fontWeight: FontWeight.w800);

  @override
  Widget buildImpl(context, content, logicContext) {
    List<Widget> _buildCards() {
      final normalText = TextStyle(
        color: Constants.textColor,
        fontSize: 16 * MediaQuery.textScaleFactorOf(context),
        height: 1.4,
      );
      return (content?.items ?? [])
          .where((item) => item.isDisplayed(logicContext))
          .map((fact) => Padding(
                padding: EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                child: ProtectYourselfCard.fromFact(fact,
                    defaultTextStyle: normalText),
              ))
          .toList();
    }

    SliverList _buildBody() =>
        SliverList(delegate: SliverChildListDelegate(_buildCards()));

    return PageScaffold(
      heroTag: HeroTags.learn,
      title: S.of(context).protectYourselfTitle,
      body: [
        content != null ? _buildBody() : LoadingIndicator(),
      ],
    );
  }

  @override
  FactContent getContent() {
    return dataSource.protectYourself;
  }
}
