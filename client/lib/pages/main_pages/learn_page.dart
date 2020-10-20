import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/content_widget.dart';
import 'package:who_app/components/learn_page_promo.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class LearnPage extends ContentWidget<IndexContent> {
  LearnPage({Key key, @required ContentStore dataSource})
      : super(key: key, dataSource: dataSource);

  final header =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);

  final List<_MenuItemTheme> menuColors = [
    _MenuItemTheme(
      backgroundColor: Constants.primaryDarkColor,
      textColor: CupertinoColors.white,
    ),
    _MenuItemTheme(
      backgroundColor: Constants.accentTealColor,
      textColor: CupertinoColors.white,
    ),
    _MenuItemTheme(
      backgroundColor: Constants.whoAccentYellowColor,
      textColor: Constants.neutralTextDarkColor,
    ),
    _MenuItemTheme(
      backgroundColor: Constants.accentColor,
      textColor: CupertinoColors.white,
    ),
  ];

  @override
  PageScaffold buildImpl(context, content, logicContext) {
    List<Widget> _buildPromo() {
      final p = content?.promos
          ?.firstWhere((element) => element.isDisplayed(logicContext));
      return <Widget>[
        if (p != null)
          _PromoItem(
            title: p.title,
            subtitle: p.subtitle,
            buttonText: p.buttonText,
            link: p.link,
            imageName: p.imageName,
          ),
      ];
    }

    Widget _buildPromos() =>
        SliverList(delegate: SliverChildListDelegate(_buildPromo()));

    List<Widget> _buildMenu() {
      return (content?.items ?? [])
          .where((item) => item.isDisplayed(logicContext))
          .toList()
          .asMap()
          .entries
          .map((entry) {
        final itemTheme = menuColors[entry.key % menuColors.length];
        return _MenuItem(
          title: entry.value.title,
          subtitle: entry.value.subtitle,
          link: entry.value.link,
          color: itemTheme.backgroundColor,
          textColor: itemTheme.textColor,
          imageName: entry.value.imageName,
        );
      }).toList();
    }

    Widget _buildBody() =>
        SliverList(delegate: SliverChildListDelegate(_buildMenu()));

    return PageScaffold(
      showBackButton: false,
      headingBorderColor: Color(0x0),
      heroTag: HeroTags.learn,
      // TODO: localize
      title: 'Learn',
      showHeader: content != null,
      header: SliverToBoxAdapter(
          child: Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 36, bottom: 12),
              // TODO: localize
              child: PageHeader.buildTitle('Learn',
                  textStyle: TextStyle(fontSize: 40)))),
      beforeHeader: <Widget>[
        _buildPromos(),
      ],
      body: <Widget>[
        content != null && logicContext != null
            ? _buildBody()
            : SliverSafeArea(sliver: LoadingIndicator()),
      ],
    );
  }

  @override
  IndexContent getContent() => dataSource.learnIndex;
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    @required this.title,
    @required this.link,
    @required this.subtitle,
    @required this.color,
    @required this.textColor,
    this.imageName,
  });

  final String title;
  final RouteLink link;
  final String subtitle;
  final Color color;
  final Color textColor;
  final String imageName;

  String get assetName {
    return imageName != null ? 'assets/svg/${imageName}.svg' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 64, minWidth: double.infinity),
      margin: const EdgeInsets.only(top: 18.0, left: 24.0, right: 24.0),
      child: Button(
        onPressed: () => link.open(context),
        padding: EdgeInsets.zero,
        backgroundColor: color,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              if (assetName != null)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: SvgPicture.asset(assetName, fit: BoxFit.fitHeight),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: ThemedText(
                  title,
                  variant: TypographyVariant.button,
                  style: TextStyle(color: textColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoItem extends StatelessWidget {
  const _PromoItem({
    @required this.title,
    @required this.link,
    @required this.subtitle,
    @required this.buttonText,
    this.imageName,
  });

  final String title;
  final RouteLink link;
  final String subtitle;
  final String buttonText;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return (LearnPagePromo(
      title: title,
      subtitle: subtitle,
      link: link,
      buttonText: buttonText,
      imageName: imageName,
    ));
  }
}

class _MenuItemTheme {
  final Color backgroundColor;
  final Color textColor;

  const _MenuItemTheme({
    @required this.backgroundColor,
    @required this.textColor,
  });
}
