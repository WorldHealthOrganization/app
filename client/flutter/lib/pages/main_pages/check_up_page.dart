import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:who_app/api/symptoms.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class CheckUpPage extends StatefulWidget {
  @override
  _CheckUpPageState createState() => _CheckUpPageState();
}

class _CheckUpPageState extends State<CheckUpPage> {
  List<SymptomResult> timeseries;

  _CheckUpPageState() : super() {
    SymptomTimeseries().addListener(refreshDashboard);
  }

  @override
  void initState() {
    super.initState();
    refreshDashboard();
  }

  void refreshDashboard() async {
    setState(() {
      timeseries = null;
    });
    final results = await SymptomTimeseries().results();
    setState(() {
      timeseries = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timeseries == null) {
      return PageScaffold(
        body: <Widget>[
          SliverToBoxAdapter(child: SizedBox(height: 64)),
          LoadingIndicator()
        ],
        title: "Check-Up",
        showHeader: false,
      );
    }
    return timeseries.isEmpty
        ? _NoEntries()
        : _Dashboard(timeseries: timeseries);
  }
}

class _Dashboard extends StatelessWidget {
  final List<SymptomResult> timeseries;

  const _Dashboard({Key key, @required this.timeseries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      disableBackButton: true,
      title: "Check-Up",
      headerTrailingWidget: Material(
        color: CupertinoColors.white,
        child: IconButton(
            icon: Icon(
              Icons.add,
              size: 48,
              color: Constants.primaryColor,
            ),
            onPressed: () {
              return Navigator.of(context, rootNavigator: true)
                  .pushNamed('/track-symptoms');
            }),
      ),
      body: <Widget>[_buildBody(context)],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        dateHeading(context),
        ...optionWidgets(),
      ]));

  List<Widget> optionWidgets() {
    return timeseries.reversed.map((v) {
      switch (v.risk) {
        case 0:
          return _TimelineItem(
            icon: FontAwesomeIcons.smileBeam,
            color: Color(0xFF219653),
            time: v.timestamp,
            title: "All good",
          );
        case 1:
          return _TimelineItem(
            icon: FontAwesomeIcons.frown,
            color: Constants.accentColor,
            time: v.timestamp,
            title: "Not so hot",
            subtitle:
                "Your symptoms are not traditionally related to COVID-19, but please monitor your symptoms.",
          );
        case 2:
          return _TimelineItem(
            icon: FontAwesomeIcons.exclamationTriangle,
            color: Constants.emergencyRedColor,
            time: v.timestamp,
            title: "COVID-19 Symptoms",
            subtitle:
                "Your symptoms are indicative of COVID-19. Please contact a healthcare professional.",
          );
        default:
          return null;
      }
    }).toList();
  }

  Widget dateHeading(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 18),
        child: ThemedText(
          "Today",
          variant: TypographyVariant.h4,
          style: TextStyle(color: Constants.primaryDarkColor),
        ));
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime time;
  final IconData icon;
  final Color color;

  _TimelineItem(
      {@required this.title,
      @required this.time,
      @required this.icon,
      @required this.color,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28,
        right: 16,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: FaIcon(
                          icon,
                          color: color,
                          size: 16,
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      color: Color(0x80000000),
                      width: 2,
                      height: subtitle != null ? 90 : 20,
                    ),
                  ]),
              SizedBox(
                width: 12,
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ThemedText(
                          this.title,
                          variant: TypographyVariant.h4,
                          style: TextStyle(color: color),
                        ),
                        if (this.subtitle != null)
                          SizedBox(
                            height: 8,
                          ),
                        if (this.subtitle != null)
                          ThemedText(
                            this.subtitle,
                            variant: TypographyVariant.body,
                          ),
                      ])),
              ThemedText(
                DateFormat.jm().format(time.toLocal()),
                variant: TypographyVariant.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      disableBackButton: true,
      headingBorderColor: Color(0x0),
      title: "Check-Up",
      header: SliverSafeArea(
          sliver: SliverToBoxAdapter(
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 36, bottom: 12),
                  // TODO: localize
                  child: PageHeader.buildTitle("Check-Up",
                      textStyle: TextStyle(fontSize: 48))))),
      body: <Widget>[_buildBody(context)],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        ...optionWidgets(),
        submitWidget(context),
      ]));

  List<Widget> optionWidgets() {
    return <Widget>[
      _ListItem(
          title:
              "You’ll answer a few questions about how you're feeling and any symptoms you may have.",
          icon: FontAwesomeIcons.fileMedical),
      _ListItem(
          title:
              "Your answers will not be shared with the WHO without your permission. ",
          icon: FontAwesomeIcons.lock),
      _ListItem(
          title:
              "By using this tool, you agree to its terms and that the WHO will not be liable for any harm relating to your use.",
          subtitle:
              "Recommendations provided by this tool do not constitute medical advice and should not be used to diagnose or treat medical conditions.",
          icon: FontAwesomeIcons.solidCheckCircle),
    ];
  }

  Widget submitWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 24,
        right: 24,
        bottom: 48,
      ),
      child: PageButton(
        Constants.primaryColor,
        "Get Started",
        () {
          return Navigator.of(context, rootNavigator: true)
              .pushNamed('/track-symptoms');
        },
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalPadding: 12,
        borderRadius: 500,
        titleStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  _ListItem({@required this.title, @required this.icon, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 60,
        bottom: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Constants.primaryColor,
            size: 24,
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
                      fontSize: 16,
                      height: 1.37,
                      color: Constants.bodyTextColor),
                ),
                if (this.subtitle != null)
                  SizedBox(
                    height: 8,
                  ),
                if (this.subtitle != null)
                  Text(this.subtitle,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.43,
                          color: Constants.bodyTextColor.withOpacity(0.76))),
              ])),
        ],
      ),
    );
  }
}
