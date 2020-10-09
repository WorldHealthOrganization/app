import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/advice_content.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class TravelAdvice extends ContentWidget<AdviceContent> {
  TravelAdvice({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(context, content, logicContext) {
    List<Widget> _getItems(BuildContext context) {
      return (content?.items ?? [])
          .where((element) => element.isDisplayed(logicContext))
          .map((item) {
        return item.isBanner
            ? _Banner(title: item.title, body: item.body)
            : _TravelAdviceListItem(
                title: item.title ?? '', description: item.body ?? '');
      }).toList();
    }

    SliverList _buildBody() {
      return SliverList(
          delegate: SliverChildListDelegate([
        ..._getItems(context),
        SizedBox(
          height: 28,
        ),
      ]));
    }

    return PageScaffold(
        heroTag: HeroTags.learn,
        body: [
          content != null ? _buildBody() : LoadingIndicator(),
        ],
        title: S.of(context).homePagePageButtonTravelAdvice);
  }

  @override
  AdviceContent getContent() {
    return dataSource.travelAdvice;
  }
}

class _Banner extends StatelessWidget {
  final String title;
  final String body;

  _Banner({@required this.title, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Constants.emergencyRedColor, width: 1.0),
          ),
        ),
        padding: const EdgeInsets.all(28.0),
        child: Column(children: <Widget>[
          if (title != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: Constants.emergencyRedColor,
                ),
                SizedBox(
                  height: 10,
                ),
                ThemedText(
                  title,
                  variant: TypographyVariant.h4,
                  style: TextStyle(
                    color: Constants.emergencyRedColor,
                    height: 1.37,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          if (body != null)
            ThemedText(
              body,
              variant: TypographyVariant.body,
              style: TextStyle(
                fontSize: 18,
                color: Constants.textColor,
              ),
            ),
        ]));
  }
}

class _TravelAdviceListItem extends StatelessWidget {
  final String title;
  final String description;

  _TravelAdviceListItem({@required this.title, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FaIcon(
            FontAwesomeIcons.solidCheckCircle,
            color: Constants.primaryColor,
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                ThemedText(
                  title,
                  variant: TypographyVariant.h4,
                  style:
                      TextStyle(height: 1.37, color: Constants.bodyTextColor),
                ),
                ThemedText(
                  description,
                  variant: TypographyVariant.body,
                  style:
                      TextStyle(fontSize: 18, color: Constants.bodyTextColor),
                ),
              ])),
        ],
      ),
    );
  }
}
