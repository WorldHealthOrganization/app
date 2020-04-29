import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/rive_animation.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/pages/main_pages/routes.dart';

class ProtectYourself extends StatefulWidget {
  final FactsDataSource dataSource;

  const ProtectYourself({Key key, @required this.dataSource}) : super(key: key);

  @override
  _ProtectYourselfState createState() => _ProtectYourselfState();
}

class _ProtectYourselfState extends State<ProtectYourself> {
  final whoBlue = Color(0xFF3D8BCC);
  final header = TextStyle(
      color: CupertinoColors.black, fontSize: 24, fontWeight: FontWeight.w800);
  FactContent _factContent;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadFacts();
  }

  // TODO: Move to a base class for "facts" based pages?
  Future _loadFacts() async {
    if (_factContent != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _factContent = await widget.dataSource(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, _factContent);
    } catch (err) {
      print("Error loading fact data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      heroTag: HeroTags.learn,
      color: Constants.greyBackgroundColor,
      title: S.of(context).protectYourselfTitle,
      body: [
        _factContent != null ? _buildBody() : LoadingIndicator(),
      ],
    );
  }

  SliverList _buildBody() =>
      SliverList(delegate: SliverChildListDelegate(_buildCards()));

  List<Widget> _buildCards() {
    final TextStyle normalText = TextStyle(
      color: Constants.textColor,
      fontSize: 16 * MediaQuery.textScaleFactorOf(context),
      height: 1.4,
    );
    final TextStyle boldText = normalText.copyWith(fontWeight: FontWeight.w700);
    return (_factContent?.items ?? []).map((fact) {
      return _ProtectYourselfCard(
        message: Html(
            data: fact.body ?? "",
            defaultTextStyle: normalText,
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "b":
                    return baseStyle.merge(boldText);
                }
              }
              return baseStyle.merge(normalText);
            }),
        child: fact.animationName != null
            ? _getAnimation(fact.animationName)
            : _getSVG('assets/svg/${fact.imageName}.svg'),
      );
    }).toList();
  }

  Widget _getSVG(String svgAssetName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: SvgPicture.asset(svgAssetName),
        ),
      );

  Widget _getAnimation(String animationName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: RiveAnimation(
            'assets/animations/$animationName.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'Untitled',
          ),
        ),
      );
}

class _ProtectYourselfCard extends StatelessWidget {
  const _ProtectYourselfCard({
    @required this.message,
    @required this.child,
  });

  final Html message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        child: Container(
          color: CupertinoColors.white,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: child,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
