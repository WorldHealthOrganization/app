import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/content/schema/symptom_checker_content.dart';
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

  _Card({@required this.content, this.iconColor});

  IconData _icon(String name) {
    if (name != null) {
      switch (name) {
        case 'call':
          return FontAwesomeIcons.phoneSquareAlt;
        case 'note':
          return FontAwesomeIcons.notesMedical;
        case 'home':
          return FontAwesomeIcons.houseUser;
        case 'bed':
          return FontAwesomeIcons.bed;
      }
    }
    return FontAwesomeIcons.commentMedical;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context));
    final TextStyle boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);
    ;

    final icon = _icon(content.iconName);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
            color: CupertinoColors.white,
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: FaIcon(
                    icon,
                    color: iconColor,
                    size: 24 * MediaQuery.of(context).textScaleFactor,
                  ),
                  constraints: BoxConstraints(
                      minWidth: 24 * MediaQuery.of(context).textScaleFactor,
                      maxWidth: 36 * MediaQuery.of(context).textScaleFactor),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        // Html widget has 2 un-modifiable pixel padding, sigh...
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: ThemedText(
                          content.title,
                          variant: TypographyVariant.body,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (content.bodyHtml != null)
                        Html(
                          customEdgeInsets: (_) => EdgeInsets.zero,
                          data: content.bodyHtml,
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
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
