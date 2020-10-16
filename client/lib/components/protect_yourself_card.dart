import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/constants.dart';

class ProtectYourselfCard extends StatelessWidget {
  final Widget child;
  final Widget message;
  final BorderRadius borderRadius;

  const ProtectYourselfCard({
    @required this.child,
    @required this.message,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    Key key,
  }) : super(key: key);

  static ProtectYourselfCard fromFact(FactItem fact,
      {bool shouldAnimate = true,
      Color childBackgroundColor = Constants.primaryColor,
      BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16.0)),
      TextStyle defaultTextStyle = const TextStyle(
          color: Constants.textColor, fontSize: 16, height: 1.4)}) {
    Widget media = SvgPicture.asset('assets/svg/${fact.imageName}.svg');
    final boldTextStyle =
        defaultTextStyle.copyWith(fontWeight: FontWeight.w700);
    return ProtectYourselfCard(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: childBackgroundColor,
          child: media,
        ),
      ),
      message: Html(
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
      ),
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        color: CupertinoColors.white,
        child: Column(
          children: <Widget>[
            child,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: message,
            ),
          ],
        ),
      ),
    );
  }
}
