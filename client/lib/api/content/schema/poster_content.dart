import 'package:who_app/api/content/content_bundle.dart';
import 'package:who_app/api/content/schema/conditional_content.dart';

/// Interpret a content bundle as poster data.
class PosterContent extends ContentBase {
  List<PosterCard> cards;

  PosterContent(ContentBundle bundle) : super(bundle, schemaName: 'poster') {
    try {
      cards = bundle.contentItems.map(_cardFromContent).toList();
    } catch (err) {
      print('Error loading poster data: $err');
      throw ContentBundleDataException();
    }
  }

  PosterCard _cardFromContent(dynamic item) {
    return PosterCard(
      title: item['title'],
      bodyHtml: item['body_html'],
      iconName: item['icon_name'],
      displayCondition: item['display_condition'],
      severe: item['severe'] ?? false,
    );
  }
}

class PosterCard with ConditionalItem {
  final String title;
  final String bodyHtml;
  final String iconName;
  @override
  final String displayCondition;
  final bool severe;

  PosterCard({
    this.title,
    this.bodyHtml,
    this.iconName,
    this.displayCondition,
    this.severe,
  });
}
