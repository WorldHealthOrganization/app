import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/home_page_sections/home_page_donate.dart';
import 'package:who_app/components/home_page_sections/home_page_header.dart';
import 'package:who_app/components/home_page_sections/home_page_information_card.dart';
import 'package:who_app/components/home_page_sections/home_page_protect_yourself.dart';
import 'package:who_app/components/home_page_sections/home_page_recent_numbers.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePage extends ContentWidget<IndexContent> {
  HomePage({@required ContentStore dataSource, Key key})
      : super(key: key, dataSource: dataSource);

  @override
  Widget buildImpl(context, content, logicContext) {
    List<Widget> _buildPromo() {
      var preHeader = <Widget>[];
      var p = content?.promos
          ?.firstWhere((element) => element.isDisplayed(logicContext));
      if (p != null) {
        preHeader.add(_HomePageSection(
          content: HomePageHeader(
            headerType: p.type,
            title: p.title,
            subtitle: p.subtitle,
            buttonText: p.buttonText,
            link: p.link,
            imageName: p.imageName,
          ),
        ));
      }
      return preHeader;
    }

    List<Widget> _buildBody(BuildContext ctx) {
      var items = content?.items;
      if (items == null) {
        return [LoadingIndicator()];
      }
      var bundleWidgets = items
          .where((item) => item.isDisplayed(logicContext))
          .map((item) => _buildItem(ctx, item))
          .toList();
      return [
        ...bundleWidgets,
        // TODO: do we want to drive donate section via the content bundle too?
        _buildDonate(),
      ];
    }

    return PageScaffold(
      showHeader: false,
      // For background scroll bleed only - white background set on _HomePageSection widgets
      color: content?.items != null
          ? Constants.primaryDarkColor
          : CupertinoColors.white,
      beforeHeader: _buildPromo(),
      body: _buildBody(context),
    );
  }

  Widget _buildItem(BuildContext ctx, IndexItem item) {
    switch (item.type) {
      case IndexItemType.information_card:
        return _buildInfoCard(item);
      case IndexItemType.protect_yourself:
        return _buildProtectYourself(item);
      case IndexItemType.recent_numbers:
        return _buildRecentNumbers(ctx, item);
      case IndexItemType.menu_list_tile:
      case IndexItemType.unknown:
        return null;
    }
    return null;
  }

  Widget _buildInfoCard(IndexItem item) {
    return _HomePageSection(
      padding: EdgeInsets.only(top: 72.0),
      content: HomePageInformationCard(
        title: item.title,
        subtitle: item.subtitle,
        buttonText: item.buttonText,
        link: item.link,
        imageName: item.imageName,
      ),
    );
  }

  Widget _buildProtectYourself(IndexItem item) {
    return _HomePageSection(
      padding: EdgeInsets.only(top: 44.0),
      header: _HomePageSectionHeader(
        title: item.title,
        linkText: item.buttonText,
        link: item.link,
      ),
      content: HomePageProtectYourself(
        dataSource: dataSource,
        link: item.link,
      ),
    );
  }

  Widget _buildRecentNumbers(BuildContext ctx, IndexItem item) {
    return _HomePageSection(
      padding: EdgeInsets.only(top: 56.0),
      header: _HomePageSectionHeader(
        title: item.title,
        linkText: item.buttonText,
        link: item.link,
      ),
      content: HomePageRecentNumbers(
        statsStore: Provider.of<StatsStore>(ctx),
        link: item.link,
      ),
    );
  }

  Widget _buildDonate() {
    return _HomePageSection(
      padding: EdgeInsets.only(top: 64.0),
      content: HomePageDonate(),
    );
  }

  @override
  IndexContent getContent() {
    return dataSource.homeIndex;
  }
}

class _HomePageSection extends StatelessWidget {
  final Widget content;
  final Widget header;
  final EdgeInsets padding;

  const _HomePageSection({
    @required this.content,
    this.header,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: CupertinoColors.white,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[if (header != null) header, content],
        ),
      ),
    );
  }
}

class _HomePageSectionHeader extends StatelessWidget {
  final String title;
  final String linkText;
  final RouteLink link;

  const _HomePageSectionHeader({
    @required this.title,
    @required this.linkText,
    @required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16.0,
        children: <Widget>[
          ThemedText(
            title,
            variant: TypographyVariant.h3,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: ThemedText(
              linkText,
              variant: TypographyVariant.button,
              style: TextStyle(
                color: Constants.neutralTextLightColor,
              ),
            ),
            onPressed: () {
              return link.open(context);
            },
          ),
        ],
      ),
    );
  }
}
