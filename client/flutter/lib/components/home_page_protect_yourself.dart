import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/constants.dart';

///========================================================
/// TODO SUMMARY:
///   1. DRY between this widget and ProtectYourself
///   2. Think through data in the content bundle (e.g. requiring image)
///   3. Localize strings
///   4. Handle content bundle schema change better
///   5. Handle error states better
///   6. Navigate to Protect Yourself page on tap of card, scrolled to tapped card
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
      return LoadingIndicator();
    }

    // TODO: better handle schema version changes
    if (_factContent.bundle.unsupportedSchemaVersionAvailable) {
      return null;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
    final TextStyle normalText = TextStyle(
      color: Constants.neutralTextDarkColor,
      fontSize: 12 * MediaQuery.textScaleFactorOf(context),
      height: 1.33,
    );
    final TextStyle boldText = normalText.copyWith(fontWeight: FontWeight.w700);
    return (_factContent?.items ?? []).map((fact) {
      // TODO: figure out better way of handling - possibly require FactContent imageName?
      final svgName = fact.imageName ?? 'wash_hands';
      return SizedBox(
        width: screenWidth * 0.75,
        child: _ProtectYourselfCard(
          message: Html(
              data: fact.body ?? "",
              defaultTextStyle: normalText,
              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "b":
                      return baseStyle.merge(boldText);
                  }
                }
                return baseStyle.merge(normalText);
              }),
          child: _getSVG(svgName),
        ),
      );
    }).toList();
  }

  Widget _getSVG(String svgAssetName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Constants.illustrationBlue1Color,
          child: SvgPicture.asset('assets/svg/${svgAssetName}.svg'),
        ),
      );
}

class _ProtectYourselfCard extends StatelessWidget {
  const _ProtectYourselfCard({
    @required this.message,
    @required this.child,
  });

  final Html message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 0.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        child: Container(
          color: CupertinoColors.white,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: child,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
