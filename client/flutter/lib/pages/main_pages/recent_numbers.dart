import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/recent_numbers_graph.dart';
import 'package:who_app/components/themed_text.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8,
                    ),
                    child: CupertinoSlidingSegmentedControl(
                      backgroundColor: Color(0xffEFEFEF),
                      children: _buildSegmentControlChildren(
                          context, this.aggregation),
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
                      thumbColor: Constants.greyBackgroundColor,
                    ),
                  ),
                  Container(height: 16.0),
                  RegionText(
                    country: "Nigeria",
                    emoji: "🇳🇬",
                  ),
                  ConstrainedBox(
                    child: RecentNumbersGraph(
                      aggregation: this.aggregation,
                      timeseries: widget.statsStore.globalStats?.timeseries,
                      dimension: DataDimension.cases,
                    ),
                    constraints: BoxConstraints(maxHeight: 224.0),
                  ),
                  Container(height: 24.0),
                  ConstrainedBox(
                    child: RecentNumbersGraph(
                      aggregation: this.aggregation,
                      timeseries: widget.statsStore.globalStats?.timeseries,
                      dimension: DataDimension.deaths,
                    ),
                    constraints: BoxConstraints(maxHeight: 224.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
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
}

class RegionText extends StatelessWidget {
  final String country;
  final String emoji;

  const RegionText({
    @required this.country,
    @required this.emoji,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ThemedText(
        "$emoji $country",
        variant: TypographyVariant.h3,
      ),
    );
  }
}
