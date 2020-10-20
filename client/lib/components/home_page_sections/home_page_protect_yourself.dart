import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

///========================================================
/// TODO SUMMARY:
///   1. Handle content bundle schema change better
///   2. Handle error states better
///   3. Navigate to Protect Yourself page on tap of card, scrolled to tapped card
///=========================================================

class HomePageProtectYourself extends ContentWidget<FactContent> {
  final RouteLink link;
  HomePageProtectYourself(
      {Key key, @required ContentStore dataSource, @required this.link})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(context, content, logicContext) {
    List<Widget> _buildCards() {
      final screenWidth = MediaQuery.of(context).size.width;
      return (content?.items ?? [])
          .where((item) => item.isDisplayed(logicContext))
          .map((fact) => SizedBox(
                width: screenWidth * 0.75,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: _HomeProtectYourselfCard(fact: fact, link: link),
                ),
              ))
          .toList();
    }

    if (content == null || logicContext == null) {
      return Padding(
        padding: EdgeInsets.all(64.0),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildCards(),
          ),
        ),
      ),
    );
  }

  @override
  FactContent getContent() {
    return dataSource.protectYourself;
  }
}

class _HomeProtectYourselfCard extends StatelessWidget {
  final FactItem fact;
  final RouteLink link;

  const _HomeProtectYourselfCard({
    @required this.fact,
    @required this.link,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: link != null
          ? () {
              link.open(context);
            }
          : null,
      borderRadius: BorderRadius.circular(16.0),
      backgroundColor: Constants.primaryDarkColor,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 20.0),
                child: _buildBody(context, fact.body),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: AspectRatio(
                    aspectRatio: 316 / 240,
                    child: SvgPicture.asset('assets/svg/${fact.imageName}.svg'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, String body) {
    final defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context),
        overrides: TextStyle(
            color: CupertinoColors.white, fontWeight: FontWeight.w500));
    final boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);
    return Html(
      data: fact.body ?? '',
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
    );
  }
}
