//TODO: ENTER CORRECT URL FOR EACH ITEM

import 'package:who_app/components/news_feed_item.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      heroTag: HeroTags.learn,
      body: [
        SliverList(
            delegate: SliverChildListDelegate([
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle1,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription1,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath1),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl1,
            index: 0,
          ),
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle2,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription2,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath2),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl2,
            index: 1,
          ),
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle3,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription3,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath3),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl3,
            index: 2,
          ),
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle4,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription4,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath4),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl4,
            index: 3,
          )
        ]))
      ],
      title: S.of(context).newsFeedTitle,
    );
  }
}
