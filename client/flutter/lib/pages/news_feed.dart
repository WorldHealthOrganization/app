//TODO: ENTER CORRECT URL FOR EACH ITEM

import 'package:who_app/components/news_feed_item.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class NewsFeed extends StatelessWidget {
  final FirebaseAnalytics analytics;
  NewsFeed(this.analytics);

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
            analytics: analytics,
          ),
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle2,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription2,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath2),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl2,
            analytics: analytics,
          ),
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle3,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription3,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath3),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl3,
            analytics: analytics,
          ),
          NewsFeedItem(
            title: S.of(context).newsFeedSliverListNewsFeedItemTitle4,
            description:
                S.of(context).newsFeedSliverListNewsFeedItemDescription4,
            imageProvider: AssetImage(
                S.of(context).newsFeedSliverListNewsFeedItemImagePath4),
            url: S.of(context).newsFeedSliverListNewsFeedItemUrl4,
            analytics: analytics,
          )
        ]))
      ],
      title: S.of(context).newsFeedTitle,
    );
  }
}
