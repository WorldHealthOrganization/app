import 'package:flutter/cupertino.dart';
import 'package:who_app/components/learn_page_promo.dart';
import 'package:who_app/api/content/schema/index_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:flutter/material.dart';
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
      disableBackButton: true,
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
          color: Color(0xFFD5F5FD),
        ),
    ];
  }

  Widget _buildBody() =>
      SliverList(delegate: SliverChildListDelegate(_buildMenu()));

  List<Widget> _buildMenu() {
    return (_content?.items ?? []).asMap().entries.map((entry) {
      return _MenuItem(
        title: entry.value.title,
        subtitle: entry.value.subtitle,
        link: entry.value.link,
        color: Constants.menuButtonColor,
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
  });

  final String title;
  final RouteLink link;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 24,
        right: 24,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: FlatButton(
          padding: const EdgeInsets.all(24),
          onPressed: () {
            return Navigator.of(context, rootNavigator: true)
                .pushNamed(link.route, arguments: link.args);
          },
          child: Column(
            mainAxisAlignment: subtitle != null
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (title != null)
                Padding(
                  padding: EdgeInsets.only(
                    top: subtitle != null ? 24 : 0,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white),
                  ),
                ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 16, height: 1.37, color: Color(0xD5FFFFFF)),
                  ),
                ),
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
    @required this.color,
  });

  final String title;
  final RouteLink link;
  final String subtitle;
  final String buttonText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return (LearnPagePromo(
      title: title,
      subtitle: subtitle,
      link: link,
      buttonText: buttonText,
    ));
  }
}
