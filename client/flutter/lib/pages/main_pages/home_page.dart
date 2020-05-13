import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/home_page_sections/home_page_donate.dart';
import 'package:who_app/components/home_page_sections/home_page_header.dart';
import 'package:who_app/components/home_page_sections/home_page_information_card.dart';
import 'package:who_app/components/home_page_sections/home_page_protect_yourself.dart';
import 'package:who_app/components/home_page_sections/home_page_recent_numbers.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePage extends StatefulWidget {
  final IndexDataSource dataSource;

  const HomePage({@required this.dataSource, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      print("Error loading home index data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      showHeader: false,
      // For background scroll bleed only - white background set on _HomePageSection widgets
      color: _content?.items != null
          ? Constants.primaryDarkColor
          : CupertinoColors.white,
      beforeHeader: _buildPromo(),
      body: _buildBody(),
    );
  }

  List<Widget> _buildPromo() {
    List<Widget> preHeader = [];
    IndexPromo p = _content?.promos
        ?.firstWhere((element) => element.isDisplayed(_logicContext));
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

  List<Widget> _buildBody() {
    List<IndexItem> items = _content?.items;
    if (items == null) {
      return [LoadingIndicator()];
    }
    List<Widget> bundleWidgets = items
        .where((item) => item.isDisplayed(_logicContext))
        .map((item) => _buildItem(item))
        .toList();
    return [
      ...bundleWidgets,
      // TODO: do we want to drive donate section via the content bundle too?
      _buildDonate(),
    ];
  }

  Widget _buildItem(IndexItem item) {
    switch (item.type) {
      case IndexItemType.information_card:
        return _buildInfoCard(item);
      case IndexItemType.protect_yourself:
        return _buildProtectYourself(item);
      case IndexItemType.recent_numbers:
        return _buildRecentNumbers(item);
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
        dataSource: FactContent.protectYourself,
      ),
    );
  }

  Widget _buildRecentNumbers(IndexItem item) {
    return _HomePageSection(
      padding: EdgeInsets.only(top: 56.0),
      header: _HomePageSectionHeader(
        title: item.title,
        linkText: item.buttonText,
        link: item.link,
      ),
      content: HomePageRecentNumbers(),
    );
  }

  Widget _buildDonate() {
    return _HomePageSection(
      padding: EdgeInsets.only(top: 64.0),
      content: HomePageDonate(),
    );
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
        padding: this.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (this.header != null) this.header,
            this.content
          ],
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
            this.title,
            variant: TypographyVariant.h3,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: ThemedText(
              this.linkText,
              variant: TypographyVariant.button,
              style: TextStyle(
                color: Constants.neutralTextLightColor,
              ),
            ),
            onPressed: () {
              return this.link.open(context);
            },
          ),
        ],
      ),
    );
  }
}
