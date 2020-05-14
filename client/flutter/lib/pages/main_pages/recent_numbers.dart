import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/recent_numbers_graph.dart';
import 'package:who_app/components/stat_card.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/api/who_service.dart';

enum DataAggregation { daily, total }
enum DataDimension { cases, deaths }

class RecentNumbersPage extends StatefulWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  _RecentNumbersPageState createState() => _RecentNumbersPageState();
}

class _RecentNumbersPageState extends State<RecentNumbersPage> {
  var aggregation = DataAggregation.total;
  var dimension = DataDimension.cases;

  Map globalStats = Map();
  DateTime lastUpdated;

  String get timeseriesKey {
    String aggregationPart;
    String dimensionPart;
    switch (this.aggregation) {
      case DataAggregation.daily:
        aggregationPart = 'daily';
        break;
      case DataAggregation.total:
        aggregationPart = 'total';
        break;
      default:
        aggregationPart = '';
    }
    switch (this.dimension) {
      case DataDimension.cases:
        dimensionPart = 'Cases';
        break;
      case DataDimension.deaths:
        dimensionPart = 'Deaths';
        break;
      default:
        dimensionPart = '';
    }
    return '${aggregationPart}${dimensionPart}';
  }

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      appBarColor: Constants.backgroundColor,
      showBackButton: ModalRoute.of(context).canPop ?? false,
      body: <Widget>[
        CupertinoSliverRefreshControl(
          builder: (context, refreshIndicatorMode, pulledExtent, b, c) {
            double topPadding = max(pulledExtent - 25.0, 0.0);
            switch (refreshIndicatorMode) {
              case RefreshIndicatorMode.drag:
                return pulledExtent > 10
                    ? Padding(
                        padding: EdgeInsets.only(top: topPadding),
                        child: Icon(CupertinoIcons.down_arrow,
                            color: CupertinoColors.systemGrey))
                    : Container();
                break;
              case RefreshIndicatorMode.refresh:
              case RefreshIndicatorMode.armed:
                return Padding(
                    padding: EdgeInsets.only(top: topPadding),
                    child: CupertinoActivityIndicator());
                break;
              default:
                return Container();
            }
          },
          onRefresh: () async {
            await widget.analytics.logEvent(name: 'RecentNumberRefresh');
            await fetchStats();
          },
          refreshIndicatorExtent: 100,
          refreshTriggerPullDistance: 100,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              child: Column(
                children: <Widget>[
                  CupertinoSlidingSegmentedControl(
                    backgroundColor: Color(0xffEFEFEF),
                    children:
                        _buildSegmentControlChildren(context, this.aggregation),
                    groupValue: this.aggregation,
                    onValueChanged: (value) {
                      widget.analytics.logEvent(
                          name: 'RecentNumberAggregation',
                          parameters: {'index': this.aggregation.index});
                      setState(
                        () {
                          this.aggregation = value;
                        },
                      );
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    thumbColor: Constants.greyBackgroundColor,
                  ),
                  Container(height: 16.0),
                  ConstrainedBox(
                    child: RecentNumbersGraph(
                      aggregation: this.aggregation,
                      timeseries: this.globalStats['timeseries'],
                      timeseriesKey: this.timeseriesKey,
                      dimension: this.dimension,
                    ),
                    constraints: BoxConstraints(maxHeight: 224.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
              color: CupertinoColors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            ),
            Container(height: 28.0),
            _buildTappableStatCard(context, DataDimension.cases),
            Container(height: 16.0),
            _buildTappableStatCard(context, DataDimension.deaths),
          ]),
        )
      ],
      title: S.of(context).latestNumbersPageTitle,
    );
  }

  void fetchStats() async {
    Map statsResponse = await WhoService.getCaseStats();
    final globalStats = statsResponse['globalStats'];
    final lastUpdated = globalStats != null
        ? DateTime.fromMicrosecondsSinceEpoch(globalStats['lastUpdated'])
        : DateTime.now();

    setState(() {
      this.globalStats = globalStats;
      this.lastUpdated = lastUpdated;
    });
  }

  Map<DataAggregation, Widget> _buildSegmentControlChildren(
      BuildContext context, DataAggregation selectedValue) {
    Map<DataAggregation, String> valueToDisplayText = {
      DataAggregation.total: S.of(context).latestNumbersPageTotalToggle,
      DataAggregation.daily: S.of(context).latestNumbersPageDailyToggle,
    };
    return valueToDisplayText.map((value, displayText) {
      return MapEntry<DataAggregation, Widget>(
          value,
          Padding(
            child: Text(
              displayText,
              style: TextStyle(
                color: value == selectedValue
                    ? Constants.primaryColor
                    : Constants.neutralTextLightColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.222,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          ));
    });
  }

  Widget _buildTappableStatCard(BuildContext context, DataDimension dimension) {
    String statKey;
    String title;
    switch (dimension) {
      case DataDimension.cases:
        statKey = 'cases';
        title = S.of(context).latestNumbersPageCasesDimension;
        break;
      case DataDimension.deaths:
        statKey = 'deaths';
        title = S.of(context).latestNumbersPageDeathsDimension;
        break;
      default:
        statKey = '';
    }
    final numFmt = NumberFormat.decimalPattern();
    final stat = this.globalStats != null && this.globalStats[statKey] != null
        ? numFmt.format(globalStats[statKey])
        : '-';
    return Padding(
      child: _TappableStatCard(
        isSelected: dimension == this.dimension,
        onTap: () {
          setState(() {
            this.dimension = dimension;
          });
        },
        stat: stat,
        title: title,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
    );
  }
}

class _TappableStatCard extends StatelessWidget {
  const _TappableStatCard({
    @required this.isSelected,
    @required this.onTap,
    @required this.stat,
    @required this.title,
  });

  final bool isSelected;
  final Function onTap;
  final String stat;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        child: Container(
          child: StatCard(
            stat: this.stat,
            title: this.title,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: this.isSelected
                    ? Constants.primaryColor
                    : CupertinoColors.white,
                width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        onTap: this.onTap,
      ),
      label: this.title,
    );
  }
}
