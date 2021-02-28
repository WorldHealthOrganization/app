import 'package:who_app/api/content/schema/conditional_content.dart';

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

  static PosterCard cardFromContent(dynamic item) {
    return PosterCard(
      title: item['title'],
      bodyHtml: item['body_html'],
      iconName: item['icon_name'],
      displayCondition: item['display_condition'],
      severe: item['severe'] ?? false,
    );
  }
}
