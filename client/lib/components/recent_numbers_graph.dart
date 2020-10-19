import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/proto/api/who/who.pb.dart';

const double padding = 30;

class RecentNumbersBarGraph extends StatefulWidget {
  final DataAggregation aggregation;
  final DataDimension dimension;
  const RecentNumbersBarGraph({
    Key key,
    this.timeseries,
    this.aggregation,
    this.dimension,
  }) : super(key: key);

  final List<StatSnapshot> timeseries;

  @override
  _RecentNumbersBarGraphState createState() => _RecentNumbersBarGraphState();
}

class _RecentNumbersBarGraphState extends State<RecentNumbersBarGraph> {
  final startDate = DateTime.utc(2020, 1, 1);

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - (padding * 2);

    return BarChart(
      BarChartData(
        axisTitleData: FlAxisTitleData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItem: (barChartGroupData, _, barRodData, index) {
              final date = DateTime.fromMillisecondsSinceEpoch(
                  widget.timeseries[index].epochMsec.toInt());
              // Abbr to fit on single line: e.g. "Oct 18, 2020"
              final formattedDate = DateFormat.yMMMd().format(date);

              final formattedCount = NumberFormat().format(barRodData.y);

              return BarTooltipItem(
                '$formattedDate\n$formattedCount',
                TextStyle(
                  color: Constants.bodyTextColor,
                ),
              );
            },
          ),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barsSpace: _buildSpace(cardWidth),
            barRods: _buildRods(cardWidth),
          ),
        ],
        titlesData: FlTitlesData(show: false),
      ),
      swapAnimationDuration: Duration(milliseconds: 750),
    );
  }

  double _buildSpace(double cardWidth) {
    if (widget.timeseries != null) {
      return cardWidth * 3 / (widget.timeseries.length * 5);
    } else {
      return cardWidth *
          3 /
          DateTime.now().toUtc().difference(startDate).inDays;
    }
  }

  List<BarChartRodData> _buildRods(double cardWidth) {
    var bars = <BarChartRodData>[];

    if (widget.timeseries != null && widget.timeseries.isNotEmpty) {
      for (var snapshot in widget.timeseries) {
        try {
          final yAxis =
              snapshot.valueBy(widget.aggregation, widget.dimension).toDouble();
          bars.add(
            BarChartRodData(
              y: yAxis,
              color: Constants.textColor.withOpacity(.3),
              width: cardWidth / (widget.timeseries.length * 3),
            ),
          );
        } catch (e) {
          print('Error adding point for snapshot: $e');
        }
      }
    } else {
      final daysSinceStart =
          DateTime.now().toUtc().difference(startDate).inDays;
      for (var i = 0; i < daysSinceStart; i++) {
        bars.add(
          BarChartRodData(
            y: 0,
            color: Constants.textColor.withOpacity(.3),
            width: cardWidth / (daysSinceStart * 3),
          ),
        );
      }
    }
    return bars;
  }
}

class RecentNumbersGraph extends StatefulWidget {
  final DataAggregation aggregation;
  final DataDimension dimension;
  final List<StatSnapshot> timeseries;

  const RecentNumbersGraph({
    Key key,
    @required this.aggregation,
    @required this.timeseries,
    @required this.dimension,
  }) : super(key: key);

  @override
  _RecentNumbersGraphState createState() => _RecentNumbersGraphState();
}

class _RecentNumbersGraphState extends State<RecentNumbersGraph> {
  Widget graph;
  final numFmt = NumberFormat.decimalPattern();
  int titleData;
  @override
  Widget build(BuildContext context) {
    graph = RecentNumbersBarGraph(
      timeseries: widget.timeseries,
      dimension: widget.dimension,
      aggregation: widget.aggregation,
    );
    try {
      titleData =
          widget.timeseries.last.valueBy(widget.aggregation, widget.dimension);
    } catch (e) {
      titleData = 0;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: CupertinoColors.white,
          child: Stack(
            overflow: Overflow.clip,
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: graph,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ThemedText(
                        numFmt.format(titleData) == '0'
                            ? '-'
                            : numFmt.format(titleData),
                        variant: TypographyVariant.h2,
                        style: TextStyle(
                          color: widget.dimension == DataDimension.cases
                              ? Constants.primaryDarkColor
                              : Constants.accentColor,
                        ),
                      ),
                      ThemedText(
                        graphTitle,
                        variant: TypographyVariant.h4,
                        style: TextStyle(
                          color: widget.dimension == DataDimension.cases
                              ? Constants.primaryDarkColor
                              : Constants.accentColor,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String get graphTitle => '$graphAggregation $graphDimension';
  String get graphAggregation {
    switch (widget.aggregation) {
      case DataAggregation.total:
        return 'Total';
      case DataAggregation.daily:
        return 'Daily';
      default:
        return '';
    }
  }

  String get graphDimension {
    switch (widget.dimension) {
      case DataDimension.cases:
        return 'cases';
      case DataDimension.deaths:
        return 'deaths';
      default:
        return '';
    }
  }
}
