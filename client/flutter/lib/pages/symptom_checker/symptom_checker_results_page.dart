import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
import 'package:who_app/components/menu_list_tile.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:who_app/pages/symptom_checker/symptom_checker_model.dart';

/// Show the results.
class SymptomCheckerResultsPage extends StatelessWidget {
  final SymptomCheckerModel model;

  const SymptomCheckerResultsPage({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      // TODO: Redo the headers
      trailing: FlatButton(
        padding: EdgeInsets.zero,
        child: ThemedText(
          "Done",
          variant: TypographyVariant.button,
          style: TextStyle(color: Constants.whoBackgroundBlueColor),
        ),
        onPressed: () =>
            Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      heroTag: HeroTags.checkUp,
      body: [
        _buildBody(context),
      ],
      title: "Check-Up",
    );
  }

  SliverList _buildBody(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
          padding: const EdgeInsets.all(28.0),
          child: Column(children: <Widget>[..._getCards(context)])),
      SizedBox(
        height: 28,
      ),
    ]));
  }

  Color _severityColor(SymptomCheckerResultSeverity s) {
    if (s == null) {
      return null;
    }
    switch (s) {
      case SymptomCheckerResultSeverity.COVID19Symptoms:
        return Constants.accentColor;
      case SymptomCheckerResultSeverity.Emergency:
        return Constants.emergencyRedColor;
      case SymptomCheckerResultSeverity.None:
        return Constants.whoBackgroundBlueColor;
      case SymptomCheckerResultSeverity.SomeSymptoms:
        return Constants.accentColor;
    }
    throw Exception("Unknown severity");
  }

  List<Widget> _getCards(BuildContext context) {
    return model.results
        .map((result) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (result.title != null)
                  ThemedText(
                    result.title,
                    variant: TypographyVariant.h2,
                    softWrap: true,
                    style: TextStyle(
                      color: _severityColor(result.severity),
                    ),
                  ),
                if (result.title != null)
                  SizedBox(
                    height: 24,
                  ),
                ...result.cards
                    .map((c) => _Card(
                          content: c,
                          iconColor: _severityColor(result.severity),
                        ))
                    .toList()
              ],
            ))
        .toList();
  }
}

class _Card extends StatelessWidget {
  final SymptomCheckerResultCard content;
  final Color iconColor;

  String get assetName {
    return this.content.iconName != null
        ? 'assets/svg/streamline-sc-${this.content.iconName}.svg'
        : null;
  }

  _Card({@required this.content, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final iconSize = 24 * MediaQuery.of(context).textScaleFactor;
    return this.content.iconName == null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _buildCardContent(context,
                titleStyle: TextStyle(color: Constants.neutralTextLightColor)))
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                  color: CupertinoColors.white,
                  padding: EdgeInsets.fromLTRB(
                      12, 18, 0, content.links != null ? 0 : 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          this.assetName,
                          color: iconColor,
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      SizedBox(
                        // its 12, but 2 is in the card content due to how Html widget works
                        width: 10,
                      ),
                      Flexible(
                        child: _buildCardContent(context),
                      ),
                    ],
                  )),
            ),
          );
  }

  Widget _divider() =>
      Divider(height: 1, thickness: 1, color: Color(0xFFC9CDD6));

  Column _buildCardContent(BuildContext context,
      {TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.w700)}) {
    final defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context));
    final boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);
    ;
    final title = ThemedText(
      content.title,
      variant: TypographyVariant.body,
      style: content.titleLink == null
          ? titleStyle
          : titleStyle.merge(TextStyle(
              color: Constants.whoBackgroundBlueColor,
            )),
    );
    final child = content.titleLink != null
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: title,
              onPressed: () => content.titleLink.open(context),
            )
          ])
        : title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          // Html widget has 2 un-modifiable pixel padding, sigh...
          padding: EdgeInsets.only(left: 2, right: 12),
          child: child,
        ),
        if (content.bodyHtml != null)
          Padding(
            // Html widget has 2 un-modifiable pixel padding, sigh...
            padding: EdgeInsets.only(
                right: 12, bottom: content.links != null ? 12 : 0),
            child: Html(
              customEdgeInsets: (_) => EdgeInsets.zero,
              data: content.bodyHtml,
              defaultTextStyle: defaultTextStyle,
              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case 'b':
                      return baseStyle.merge(boldTextStyle);
                  }
                }
                return baseStyle.merge(defaultTextStyle);
              },
            ),
          ),
        if (content.links != null)
          ...(content.links
              .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _divider(),
                        MenuListTile(
                          hasArrow: false,
                          contentPadding: EdgeInsets.zero,
                          title: e.title,
                          onTap: () => e.link.open(context),
                          titleStyle: TextStyle(color: iconColor),
                        )
                      ]))
              .toList())
      ],
    );
  }
}
