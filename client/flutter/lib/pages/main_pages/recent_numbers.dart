import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/recent_numbers_graph.dart';
import 'package:who_app/components/stat_card.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/proto/api/who/who.pb.dart';

enum DataAggregation { daily, total }
enum DataDimension { cases, deaths }

extension StatSnapshotSlicing on StatSnapshot {
  int valueBy(DataAggregation agg, DataDimension dim) {
    switch (agg) {
      case DataAggregation.daily:
        switch (dim) {
          case DataDimension.cases:
            return this.dailyCases.toInt();
          case DataDimension.deaths:
            return this.dailyDeaths.toInt();
        }
        throw UnsupportedError("Unknown dimension");
      case DataAggregation.total:
        switch (dim) {
          case DataDimension.cases:
            return this.totalCases.toInt();
          case DataDimension.deaths:
            return this.totalDeaths.toInt();
        }
        throw UnsupportedError("Unknown dimension");
    }
    throw UnsupportedError("Unknown aggregation");
  }
}

extension CaseStatsSlicing on CaseStats {
  int valueBy(DataDimension dim) {
    switch (dim) {
      case DataDimension.cases:
        return this.hasCases() ? this.cases.toInt() : null;
      case DataDimension.deaths:
        return this.hasDeaths() ? this.deaths.toInt() : null;
    }
    throw UnsupportedError("Unknown dimension");
  }
}

class RecentNumbersPage extends StatefulWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final StatsStore statsStore;

  RecentNumbersPage({Key key, @required this.statsStore}) : super(key: key);

  @override
  _RecentNumbersPageState createState() => _RecentNumbersPageState();
}

class _RecentNumbersPageState extends State<RecentNumbersPage> {
  var aggregation = DataAggregation.total;
  var dimension = DataDimension.cases;

  @override
  void initState() {
    super.initState();
    widget.statsStore.update();
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
            await widget.statsStore.update();
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
                    child: Observer(
                        builder: (ctx) => RecentNumbersGraph(
                              aggregation: this.aggregation,
                              timeseries:
                                  widget.statsStore.globalStats?.timeseries,
                              dimension: this.dimension,
                            )),
                    constraints: BoxConstraints(maxHeight: 224.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
              color: CupertinoColors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            ),
            Container(height: 28.0),
            Observer(
                builder: (ctx) => _buildTappableStatCard(
                    ctx, DataDimension.cases, widget.statsStore.globalStats)),
            Container(height: 16.0),
            Observer(
                builder: (ctx) => _buildTappableStatCard(
                    ctx, DataDimension.deaths, widget.statsStore.globalStats)),
          ]),
        )
      ],
      title: S.of(context).latestNumbersPageTitle,
    );
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

  Widget _buildTappableStatCard(
      BuildContext context, DataDimension dimension, CaseStats globalStats) {
    String title;
    switch (dimension) {
      case DataDimension.cases:
        title = S.of(context).latestNumbersPageCasesDimension;
        break;
      case DataDimension.deaths:
        title = S.of(context).latestNumbersPageDeathsDimension;
        break;
      default:
    }
    final numFmt = NumberFormat.decimalPattern();
    final stat = globalStats != null && globalStats.valueBy(dimension) != null
        ? numFmt.format(globalStats.valueBy(dimension))
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
