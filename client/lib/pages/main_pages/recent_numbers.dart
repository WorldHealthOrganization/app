import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:who_app/api/iso_country.dart';
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
            return dailyCases.toInt();
          case DataDimension.deaths:
            return dailyDeaths.toInt();
        }
        throw UnsupportedError('Unknown dimension');
      case DataAggregation.total:
        switch (dim) {
          case DataDimension.cases:
            return totalCases.toInt();
          case DataDimension.deaths:
            return totalDeaths.toInt();
        }
        throw UnsupportedError('Unknown dimension');
    }
    throw UnsupportedError('Unknown aggregation');
  }
}

extension CaseStatsSlicing on CaseStats {
  int valueBy(DataDimension dim) {
    switch (dim) {
      case DataDimension.cases:
        return hasCases() ? cases.toInt() : null;
      case DataDimension.deaths:
        return hasDeaths() ? deaths.toInt() : null;
    }
    throw UnsupportedError('Unknown dimension');
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
  var aggregation = DataAggregation.daily;
  var dimension = DataDimension.cases;

  @override
  void initState() {
    super.initState();
    widget.statsStore.update();
  }

  @override
  Widget build(BuildContext context) {
    final countryList = Provider.of<IsoCountryList>(context);
    final countryCode = widget.statsStore.countryIsoCode;
    return Observer(
      builder: (context) => PageScaffold(
        appBarColor: Constants.backgroundColor,
        showBackButton: ModalRoute.of(context).canPop ?? false,
        appBarBottom: PreferredSize(
          preferredSize: Size(200, 66),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              0,
              24,
              24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CupertinoSlidingSegmentedControl(
                  backgroundColor: Color(0xffEFEFEF),
                  children: _buildSegmentControlChildren(context, aggregation),
                  groupValue: aggregation,
                  onValueChanged: (value) {
                    widget.analytics.logEvent(
                        name: 'RecentNumberAggregation',
                        parameters: {'index': aggregation.index});
                    setState(
                      () {
                        aggregation = value;
                      },
                    );
                  },
                  thumbColor: Constants.greyBackgroundColor,
                ),
              ],
            ),
          ),
        ),
        body: <Widget>[
          CupertinoSliverRefreshControl(
            builder: (context, refreshIndicatorMode, pulledExtent, b, c) {
              final topPadding = max(pulledExtent - 25.0, 0.0);
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
                    if (countryCode != null) ...[
                      _JurisdictionStats(
                        aggregation: aggregation,
                        emoji: countryList.countries[countryCode]?.emoji ?? '',
                        name: countryList.countries[countryCode]?.name ??
                            countryCode,
                        stats: widget.statsStore.countryStats,
                        key: Key(countryCode),
                      ),
                      Container(height: 16.0),
                    ],
                    _JurisdictionStats(
                      aggregation: aggregation,
                      emoji: '🌍',
                      name: 'Global',
                      stats: widget.statsStore.globalStats,
                      key: Key('Global'),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ]),
          )
        ],
        title: S.of(context).latestNumbersPageTitle,
      ),
    );
  }

  Map<DataAggregation, Widget> _buildSegmentControlChildren(
      BuildContext context, DataAggregation selectedValue) {
    var valueToDisplayText = {
      // TODO: Localize - need to regenerate translation keys as this string was changed
      DataAggregation.daily: 'Daily',
      DataAggregation.total: S.of(context).latestNumbersPageTotalToggle,
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

class _JurisdictionStats extends StatelessWidget {
  const _JurisdictionStats({
    Key key,
    @required this.name,
    @required this.emoji,
    @required this.aggregation,
    @required this.stats,
  }) : super(key: key);

  final DataAggregation aggregation;
  final String name, emoji;
  final CaseStats stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegionText(
          country: name,
          emoji: emoji,
        ),
        ConstrainedBox(
          child: RecentNumbersGraph(
            aggregation: aggregation,
            timeseries: stats?.timeseries,
            dimension: DataDimension.cases,
          ),
          constraints: BoxConstraints(maxHeight: 224.0),
        ),
        Container(height: 24.0),
        ConstrainedBox(
          child: RecentNumbersGraph(
            aggregation: aggregation,
            timeseries: stats?.timeseries,
            dimension: DataDimension.deaths,
          ),
          constraints: BoxConstraints(maxHeight: 224.0),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
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
        '$emoji $country',
        variant: TypographyVariant.h3,
      ),
    );
  }
}
