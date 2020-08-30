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
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class CheckUpPosterPage extends ContentWidget<PosterContent> {
  CheckUpPosterPage({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(
      BuildContext context, PosterContent content, LogicContext logicContext) {
    final bool inHomePage = !ModalRoute.of(context).canPop;

    List<Widget> _getCards() {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...content.cards
                .where((item) => item.isDisplayed(logicContext))
                .toList()
                .map((c) => _Card(
                      content: c,
                      iconColor: c.severe
                          ? Constants.emergencyRedColor
                          : Constants.accentColor,
                    ))
                .toList()
          ],
        )
      ];
    }

    SliverList _buildBody() {
      return SliverList(
          delegate: SliverChildListDelegate([
        Container(
            padding: const EdgeInsets.all(28.0),
            child: Column(children: <Widget>[..._getCards()])),
        SizedBox(
          height: 28,
        ),
      ]));
    }

    return PageScaffold(
      showBackButton: !inHomePage,
      // TODO: localize
      title: "Check-Up",
      header: inHomePage
          ? SliverSafeArea(
              top: true,
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 36, 16, 20),
                  // TODO: localize
                  child: PageHeader.buildTitle(
                    "Check-Up",
                    textStyle:
                        ThemedText.styleForVariant(TypographyVariant.title)
                            .merge(
                      TextStyle(color: Constants.primaryDarkColor),
                    ),
                  ),
                ),
              ),
            )
          : null,
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
                  padding: EdgeInsets.fromLTRB(12, 18, 0, 18),
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
      style: titleStyle,
    );
    final child = title;
    final htmlTextStyle = (dom.Node node, TextStyle baseStyle) {
      if (node is dom.Element) {
        switch (node.localName) {
          case 'b':
            return baseStyle.merge(boldTextStyle);
        }
      }
      return baseStyle.merge(defaultTextStyle);
    };
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
            padding: EdgeInsets.only(right: 12, bottom: 0),
            child: Html(
              customEdgeInsets: (_) => EdgeInsets.zero,
              data: content.bodyHtml,
              defaultTextStyle: defaultTextStyle,
              customTextStyle: htmlTextStyle,
            ),
          ),
      ],
    );
  }
}
