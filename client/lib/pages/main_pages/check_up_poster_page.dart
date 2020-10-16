import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/poster_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class CheckUpPosterPage extends ContentWidget<PosterContent> {
  CheckUpPosterPage({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(
      BuildContext context, PosterContent content, LogicContext logicContext) {
    final inHomePage = !ModalRoute.of(context).canPop;

    List<Widget> _getCards() {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...content.cards
                .where((item) => item.isDisplayed(logicContext))
                .toList()
                .asMap()
                .entries
                .map((entry) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 32.0),
                      decoration: entry.key > 0
                          ? BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color: Constants.neutral3Color)),
                            )
                          : null,
                      child: _Card(
                        content: entry.value,
                        iconColor: entry.value.severe
                            ? Constants.emergencyRedColor
                            : Constants.accentColor,
                      ),
                    ))
                .toList()
          ],
        )
      ];
    }

    SliverList _buildBody() {
      return SliverList(
          delegate: SliverChildListDelegate([
        Column(children: <Widget>[..._getCards()]),
        SizedBox(
          height: 28,
        ),
      ]));
    }

    return PageScaffold(
      showBackButton: !inHomePage,
      // TODO: localize
      title: 'Check-Up',
      body: <Widget>[
        content != null && logicContext != null
            ? _buildBody()
            : SliverSafeArea(sliver: LoadingIndicator())
      ],
    );
  }

  @override
  PosterContent getContent() => dataSource.symptomPoster;
}

class _Card extends StatelessWidget {
  final PosterCard content;
  final Color iconColor;

  String get assetName {
    return content.iconName != null
        ? 'assets/svg/streamline-sc-${content.iconName}.svg'
        : null;
  }

  _Card({@required this.content, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final iconSize = 24 * MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          assetName,
          color: iconColor,
          width: iconSize,
          height: iconSize,
        ),
        SizedBox(
          height: 12.0,
        ),
        ThemedText(
          content.title,
          variant: TypographyVariant.h3,
          style: TextStyle(color: iconColor),
        ),
        if (content.bodyHtml != null) _buildBodyHtml(context),
      ],
    );
  }

  Widget _buildBodyHtml(BuildContext context) {
    final defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context));
    final boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);
    ;
    final htmlTextStyle = (dom.Node node, TextStyle baseStyle) {
      if (node is dom.Element) {
        switch (node.localName) {
          case 'b':
            return baseStyle.merge(boldTextStyle);
        }
      }
      return baseStyle.merge(defaultTextStyle);
    };
    return Padding(
      // Html widget has 2 un-modifiable pixel padding, sigh...
      padding: EdgeInsets.only(right: 12, bottom: 0),
      child: Html(
        customEdgeInsets: (_) => EdgeInsets.zero,
        data: content.bodyHtml,
        defaultTextStyle: defaultTextStyle,
        customTextStyle: htmlTextStyle,
      ),
    );
  }
}
