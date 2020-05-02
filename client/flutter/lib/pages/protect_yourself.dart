import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/protect_yourself_card.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/generated/l10n.dart';
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
    return (_factContent?.items ?? [])
        .map((fact) => Padding(
              padding: EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              child: ProtectYourselfCard.fromFact(fact,
                  defaultTextStyle: normalText),
            ))
        .toList();
  }
}
