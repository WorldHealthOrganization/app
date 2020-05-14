import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/content/schema/advice_content.dart';
import 'package:who_app/api/display_conditions.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/pages/main_pages/routes.dart';

class TravelAdvice extends StatefulWidget {
  final AdviceDataSource dataSource;

  const TravelAdvice({Key key, @required this.dataSource}) : super(key: key);

  @override
  _TravelAdviceState createState() => _TravelAdviceState();
}

class _TravelAdviceState extends State<TravelAdvice> {
  AdviceContent _adviceContent;
  LogicContext _logicContext;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadAdvice();
  }

  Future _loadAdvice() async {
    if (_adviceContent != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _logicContext = await LogicContext.generate();
      _adviceContent = await widget.dataSource(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, _adviceContent);
    } catch (err) {
      print("Error loading advice data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        heroTag: HeroTags.learn,
        body: [
          _adviceContent != null ? _buildBody() : LoadingIndicator(),
        ],
        title: S.of(context).homePagePageButtonTravelAdvice);
  }

  SliverList _buildBody() {
    return SliverList(
        delegate: SliverChildListDelegate([
      ..._getItems(context),
      SizedBox(
        height: 28,
      ),
    ]));
  }

  List<Widget> _getItems(BuildContext context) {
    return (_adviceContent?.items ?? [])
        .where((element) => element.isDisplayed(_logicContext))
        .map((item) {
      return item.isBanner
          ? _Banner(title: item.title, body: item.body)
          : _TravelAdviceListItem(
              title: item.title ?? "", description: item.body ?? "");
    }).toList();
  }
}

class _Banner extends StatelessWidget {
  final String title;
  final String body;

  _Banner({@required this.title, @required this.body});

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Constants.emergencyRedColor, width: 1.0),
          ),
        ),
        padding: const EdgeInsets.all(28.0),
        child: Column(children: <Widget>[
          if (title != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: Constants.emergencyRedColor,
                ),
                SizedBox(
                  height: 10,
                ),
                ThemedText(
                  title,
                  variant: TypographyVariant.h4,
                  style: TextStyle(
                    color: Constants.emergencyRedColor,
                    height: 1.37,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          if (body != null)
            ThemedText(
              body,
              variant: TypographyVariant.body,
              style: TextStyle(
                fontSize: 18,
                color: Constants.textColor,
              ),
            ),
        ]));
  }
}

class _TravelAdviceListItem extends StatelessWidget {
  final String title;
  final String description;

  _TravelAdviceListItem({@required this.title, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FaIcon(
            FontAwesomeIcons.solidCheckCircle,
            color: Constants.primaryColor,
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                ThemedText(
                  this.title,
                  variant: TypographyVariant.h4,
                  style:
                      TextStyle(height: 1.37, color: Constants.bodyTextColor),
                ),
                ThemedText(
                  this.description,
                  variant: TypographyVariant.body,
                  style:
                      TextStyle(fontSize: 18, color: Constants.bodyTextColor),
                ),
              ])),
        ],
      ),
    );
  }
}
