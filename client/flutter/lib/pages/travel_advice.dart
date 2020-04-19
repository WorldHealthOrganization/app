import 'package:who_app/api/content/schema/advice_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

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
        showShareBottomBar: false,
        announceRouteManually: true,
        body: [
          _adviceContent != null ? _buildBody(context) : _buildLoading(),
        ],
        title: S.of(context).homePagePageButtonTravelAdvice);
  }

  SliverList _buildBody(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        color: Color(0xffD82037),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Html(
          data: _adviceContent?.banner ?? "",
          defaultTextStyle: TextStyle(
            color: Colors.white,
            // The Html widget isn't using the textScaleFactor so here's
            // the next best place to incorporate it
            fontSize: 18 * MediaQuery.textScaleFactorOf(context),
            height: 1.2,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Semantics(
          header: true,
          child: Text(
            S.of(context).travelAdvicePageListTitle,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xff050C1D)),
          ),
        ),
      ),
      ..._getItems(context),
      SizedBox(
        height: 30,
      ),
      if (_adviceContent?.recommendationsLink != null) _buildLinkButton(context)
    ]));
  }

  Padding _buildLinkButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: PageButton(
        Color(0xff008DC9),
        S.of(context).travelAdvicePageButtonGeneralRecommendations,
        () => launch(_adviceContent.recommendationsLink),
        description: _adviceContent?.recommendations ?? "",
        verticalPadding: 16,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        descriptionColor: Colors.white,
      ),
    );
  }

  SliverToBoxAdapter _buildLoading() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.all(48.0),
      child: CupertinoActivityIndicator(),
    ));
  }

  List<Widget> _getItems(BuildContext context) {
    return (_adviceContent?.items ?? []).map((item) {
      return TravelAdviceListItem(
          imageSrc: 'assets/travel_advice/${item.imageName}.png',
          description: item.body ?? "");
    }).toList();
  }
}

class TravelAdviceListItem extends StatelessWidget {
  final String description;
  final String imageSrc;

  TravelAdviceListItem({@required this.description, @required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              this.imageSrc,
              height: 109,
              width: 109,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
              child: Text(
            this.description,
            style: TextStyle(fontSize: 18, color: Color(0xff3C4245)),
          )),
        ],
      ),
    );
  }
}
