import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/content/schema/advice_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TravelAdvice extends StatefulWidget {
  final AdviceDataSource dataSource;

  const TravelAdvice({Key key, @required this.dataSource}) : super(key: key);

  @override
  _TravelAdviceState createState() => _TravelAdviceState();
}

class _TravelAdviceState extends State<TravelAdvice> {
  AdviceContent _adviceContent;

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
        announceRouteManually: true,
        body: [_adviceContent != null ? _buildBody() : LoadingIndicator()],
        title: S.of(context).homePagePageButtonTravelAdvice);
  }

  SliverList _buildBody() {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
          padding: const EdgeInsets.all(28.0),
          child: Column(children: <Widget>[
            if (_adviceContent?.banner != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.exclamationTriangle,
                    color: Constants.emergencyRed,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _adviceContent.banner,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Constants.emergencyRed,
                      height: 1.37,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            if (_adviceContent?.body != null)
              Text(
                _adviceContent.body,
                style: TextStyle(
                  fontSize: 18,
                  color: Constants.textColor,
                  height: 1.37,
                ),
              ),
          ])),
      ..._getItems(context),
      SizedBox(
        height: 28,
      ),
    ]));
  }

  List<Widget> _getItems(BuildContext context) {
    return (_adviceContent?.items ?? []).map((item) {
      return TravelAdviceListItem(
          title: item.title ?? "", description: item.body ?? "");
    }).toList();
  }
}

class TravelAdviceListItem extends StatelessWidget {
  final String title;
  final String description;

  TravelAdviceListItem({@required this.title, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
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
                Text(
                  this.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.37,
                      color: Constants.bodyTextColor),
                ),
                Text(
                  this.description,
                  style: TextStyle(
                      fontSize: 18,
                      height: 1.37,
                      color: Constants.bodyTextColor),
                ),
              ])),
        ],
      ),
    );
  }
}
