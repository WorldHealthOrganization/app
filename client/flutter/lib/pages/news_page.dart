//TODO: ENTER CORRECT URL FOR EACH ITEM

import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/menu_list_tile.dart';
// import 'package:who_app/components/news_feed_item.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class NewsIndexPage extends StatefulWidget {
  final IndexDataSource dataSource;

  const NewsIndexPage({Key key, @required this.dataSource}) : super(key: key);

  @override
  _NewsIndexState createState() => _NewsIndexState();
}

class _NewsIndexState extends State<NewsIndexPage> {
  IndexContent _content;
  LogicContext _logicContext;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadIndex();
  }

  Future _loadIndex() async {
    if (_content != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _logicContext = await LogicContext.generate();
      _content = await widget.dataSource(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, _content);
    } catch (err) {
      print("Error loading learn index data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      heroTag: HeroTags.learn,
      title: S.of(context).newsFeedTitle,
      body: <Widget>[
        _content != null
            ? _buildBody()
            : SliverSafeArea(sliver: LoadingIndicator()),
      ],
    );
  }

  Widget _buildBody() =>
      SliverList(delegate: SliverChildListDelegate(_buildMenu()));

  List<Widget> _buildMenu() {
    final divider = Container(
        height: 0.5,
        margin: EdgeInsets.only(
          left: 24.0,
        ),
        color: Constants.neutral3Color);
    return (_content?.items ?? [])
        .where((item) =>
            item.isDisplayed(_logicContext) &&
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
}
