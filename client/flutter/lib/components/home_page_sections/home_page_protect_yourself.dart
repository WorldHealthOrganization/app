import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

///========================================================
/// TODO SUMMARY:
///   1. Handle content bundle schema change better
///   2. Handle error states better
///   3. Navigate to Protect Yourself page on tap of card, scrolled to tapped card
///=========================================================

class HomePageProtectYourself extends StatefulWidget {
  final FactsDataSource dataSource;

  const HomePageProtectYourself({Key key, @required this.dataSource})
      : super(key: key);

  @override
  _HomePageProtectYourself createState() => _HomePageProtectYourself();
}

class _HomePageProtectYourself extends State<HomePageProtectYourself> {
  FactContent _factContent;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadFacts();
  }

  Future _loadFacts() async {
    if (_factContent != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _factContent = await widget.dataSource(locale);
    } catch (err) {
      print("Error loading fact data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_factContent == null) {
      return Padding(
        padding: EdgeInsets.all(64.0),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    // TODO: better handle schema version changes
    if (_factContent.bundle.unsupportedSchemaVersionAvailable) {
      return null;
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

  List<Widget> _buildCards() {
    final screenWidth = MediaQuery.of(context).size.width;
    return (_factContent?.items ?? [])
        .map((fact) => SizedBox(
              width: screenWidth * 0.75,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: _HomeProtectYourselfCard(fact: fact),
              ),
            ))
        .toList();
  }
}

class _HomeProtectYourselfCard extends StatelessWidget {
  final FactItem fact;

  const _HomeProtectYourselfCard({
    @required this.fact,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        color: Constants.primaryDarkColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 20.0),
              child: _buildBody(context, this.fact.body),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: 316 / 240,
                  child:
                      SvgPicture.asset('assets/svg/${this.fact.imageName}.svg'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, String body) {
    final TextStyle defaultTextStyle = ThemedText.htmlStyleForVariant(
        TypographyVariant.body,
        textScaleFactor: MediaQuery.textScaleFactorOf(context),
        overrides: TextStyle(
            color: CupertinoColors.white, fontWeight: FontWeight.w500));
    final TextStyle boldTextStyle =
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
