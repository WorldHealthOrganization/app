//TODO: ENTER CORRECT URL FOR EACH ITEM

import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/menu_list_tile.dart';
// import 'package:who_app/components/news_feed_item.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class NewsIndexPage extends ContentWidget<IndexContent> {
  NewsIndexPage({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(context, content, logicContext) {
    List<Widget> _buildMenu() {
      final divider = Container(
          height: 0.5,
          margin: EdgeInsets.only(
            left: 24.0,
          ),
          color: Constants.neutral3Color);
      return (content?.items ?? [])
          .where((item) =>
              item.isDisplayed(logicContext) &&
              item.type == IndexItemType.menu_list_tile)
          .map((item) {
        return Column(
          children: <Widget>[
            MenuListTile(
              title: item.title,
              subtitle: item.subtitle,
              contentPadding: EdgeInsets.all(24.0),
              onTap: () async {
                return item.link.open(context);
              },
            ),
            divider,
          ],
        );
      }).toList();
    }

    Widget _buildBody() =>
        SliverList(delegate: SliverChildListDelegate(_buildMenu()));

    return PageScaffold(
      heroTag: HeroTags.learn,
      title: S.of(context).newsFeedTitle,
      body: <Widget>[
        content != null
            ? _buildBody()
            : SliverSafeArea(sliver: LoadingIndicator()),
      ],
    );
  }

  @override
  IndexContent getContent() {
    return dataSource.newsIndex;
  }
}
