import 'package:WHOFlutter/api/content/dynamic_content.dart';
import 'package:WHOFlutter/components/carousel.dart';
import 'package:WHOFlutter/components/page_scaffold/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef FactsDataSource = Future<List<FactItem>> Function(BuildContext);

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
  List<FactItem> _factsData;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Note: this depends on the build context for the locale and hence is not
    // Note: available at the usual initState() time.
    await _loadData();
  }

  Future _loadData() async {
    // Fetch the facts data.
    if (_factsData != null) {
      return;
    }
    _factsData = await widget.dataSource(context);
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List items = (_factsData ?? [])
        .map((fact) => CarouselSlide(
              key: UniqueKey(),
              title: fact.title,
              graphic: SvgPicture.asset("assets/svg/${fact.imageName}.svg"),
              body: fact.body,
            ))
        .toList();

    // Begin: TESTING
    /*
    List<CarouselSlide> items = [
      CarouselSlide(
        key: UniqueKey(),
        title: 'Cold weather and snow <em>Cannot</em> kill the new coronavirus.',
        graphic: SvgPicture.asset("assets/svg/snowflake.svg"),
        body:
        '<b>There is no reason to believe that cold weather can kill the new coronavirus or other diseases.</b> The normal human body temperature remains around 36.5°C to 37°C, regardless of the external temperature or weather.\nThere is no reason to believe that cold weather can kill the new coronavirus or other diseases. The normal human body temperature remains around 36.5°C to 37°C, regardless of the external temperature or weather.'
            +'<b>There is no reason to believe that cold weather can kill the new coronavirus or other diseases.</b> The normal human body temperature remains around 36.5°C to 37°C, regardless of the external temperature or weather.\nThere is no reason to believe that cold weather can kill the new coronavirus or other diseases. The normal human body temperature remains around 36.5°C to 37°C, regardless of the external temperature or weather.'
            +'<b>There is no reason to believe that cold weather can kill the new coronavirus or other diseases.</b> The normal human body temperature remains around 36.5°C to 37°C, regardless of the external temperature or weather.\nThere is no reason to believe that cold weather can kill the new coronavirus or other diseases. The normal human body temperature remains around 36.5°C to 37°C, regardless of the external temperature or weather.'
      )
    ];
    items += items;
    items += items;
    items += items;
     */
    // End: TESTING

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
          color: Colors.white,
          child: items.isNotEmpty ? CarouselView(items: items) : Container()),
    );
  }
}
