import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/components/learn_page_promo.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class LearnPage extends StatefulWidget {
  final IndexDataSource dataSource;

  const LearnPage({Key key, @required this.dataSource}) : super(key: key);

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final header =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);
  IndexContent _content;
  LogicContext _logicContext;
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
      showBackButton: false,
      headingBorderColor: Color(0x0),
      heroTag: HeroTags.learn,
      // TODO: localize
      title: "Learn",
      showHeader: _content != null,
      header: SliverToBoxAdapter(
          child: Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 36, bottom: 12),
              // TODO: localize
              child: PageHeader.buildTitle("Learn",
                  textStyle: TextStyle(fontSize: 40)))),
      beforeHeader: <Widget>[
        _buildPromos(),
      ],
      body: <Widget>[
        _content != null
            ? _buildBody()
            : SliverSafeArea(sliver: LoadingIndicator()),
      ],
    );
  }

  Widget _buildPromos() =>
      SliverList(delegate: SliverChildListDelegate(_buildPromo()));
  //Column(children:_buildPromo());

  List<Widget> _buildPromo() {
    final p = _content?.promo;
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

  Widget _buildBody() =>
      SliverList(delegate: SliverChildListDelegate(_buildMenu()));

  List<Widget> _buildMenu() {
    Logic logic = Logic();
    return (_content?.items ?? [])
        .where((item) => logic.evaluateCondition(
            condition: item.displayCondition, context: _logicContext))
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
    return imageName != null ? 'assets/svg/${this.imageName}.svg' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 64, minWidth: double.infinity),
      margin: const EdgeInsets.only(top: 18.0, left: 24.0, right: 24.0),
      child: FlatButton(
        onPressed: () => link.open(context),
        padding: EdgeInsets.zero,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
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
