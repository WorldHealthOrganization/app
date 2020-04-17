import 'package:WHOFlutter/api/content/schema/fact_content.dart';
import 'package:WHOFlutter/components/carousel/carousel.dart';
import 'package:WHOFlutter/components/carousel/carousel_slide.dart';
import 'package:WHOFlutter/components/dialogs.dart';
import 'package:WHOFlutter/components/page_scaffold/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A Data driven series of questions and answers using HTML fragments.
class FactsCarouselPage extends StatefulWidget {
  final String title;
  final FactsDataSource dataSource;

  const FactsCarouselPage(
      {Key key, @required this.title, @required this.dataSource})
      : super(key: key);

  @override
  _FactsCarouselPageState createState() => _FactsCarouselPageState();
}

class _FactsCarouselPageState extends State<FactsCarouselPage> {
  FactContent _factContent;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Note: this depends on the build context for the locale and hence is not
    // Note: available at the usual initState() time.
    await _loadFacts();
  }

  // TODO: Move to a base class for "facts" based pages?
  Future<void> _loadFacts() async {
    if (_factContent != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _factContent = await widget.dataSource(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, _factContent);
    } catch (err) {
      print("Error loading fact data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List items = (_factContent?.items ?? [])
        .map((fact) => CarouselSlide(
              key: UniqueKey(),
              title: fact.title,
              graphic: _getSVG(fact.imageName),
              body: fact.body,
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: PageHeader.textColor, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: PageHeader.buildTitle("Get the Facts"),
        elevation: 0,
      ),
      body: Container(
          child: items.isNotEmpty ? CarouselView(items: items) : Container()),
    );
  }

  SvgPicture _getSVG(String imageName) {
    return imageName != null
        ? SvgPicture.asset("assets/svg/${imageName}.svg")
        : null;
  }
}
