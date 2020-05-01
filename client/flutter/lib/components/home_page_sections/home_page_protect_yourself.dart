import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/protect_yourself_card.dart';
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
    return (_factContent?.items ?? [])
        .map((fact) => SizedBox(
              width: screenWidth * 0.75,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: ProtectYourselfCard.fromFact(fact,
                    defaultTextStyle: normalText,
                    shouldAnimate: false,
                    borderRadius: BorderRadius.circular(8.0),
                    childBackgroundColor: Constants.illustrationBlue1Color),
              ),
            ))
        .toList();
  }
}
