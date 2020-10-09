import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/carousel/carousel.dart';
import 'package:who_app/components/carousel/carousel_slide.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

/// A Data driven series of questions and answers using HTML fragments.
abstract class FactsCarouselPage extends ContentWidget<FactContent> {
  final String title;

  FactsCarouselPage(
      {Key key, @required this.title, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(context, content, logicContext) {
    List items = (content?.items ?? [])
        .where((item) => item.isDisplayed(logicContext))
        .toList()
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final fact = entry.value;
      return CarouselSlide(
        key: UniqueKey(),
        title: fact.title,
        graphic: _getSVG(fact.imageName),
        body: fact.body,
        index: index,
      );
    }).toList();

    return Material(
      child: Column(
        children: <Widget>[
          PageHeader(inSliver: false, title: 'Get the Facts'),
          Expanded(
            child: items.isNotEmpty //
                ? CarouselView(items: items)
                : Container(),
          ),
        ],
      ),
    );
  }

  SvgPicture _getSVG(String imageName) {
    return imageName != null
        ? SvgPicture.asset('assets/svg/${imageName}.svg')
        : null;
  }
}

class GetTheFactsPage extends FactsCarouselPage {
  GetTheFactsPage(
      {Key key, @required String title, @required ContentStore dataSource})
      : super(key: key, title: title, dataSource: dataSource);

  @override
  FactContent getContent() {
    return dataSource.getTheFacts;
  }
}
