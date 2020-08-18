import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/pages/main_pages/recent_numbers.dart';
import 'package:who_app/proto/api/who/who.pb.dart';

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
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        axisTitleData: FlAxisTitleData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: _buildRods(MediaQuery.of(context).size.width),
          ),
        ],
        titlesData: FlTitlesData(show: false),
      ),
      swapAnimationDuration: Duration(milliseconds: 750),
    );
  }

  List<BarChartRodData> _buildRods(double screenWidth) {
    List<BarChartRodData> bars = <BarChartRodData>[];
    final startDate = DateTime.utc(2020, 1, 1);
    if (widget.timeseries != null && widget.timeseries.isNotEmpty) {
      for (var snapshot in widget.timeseries) {
        try {
          double yAxis =
              snapshot.valueBy(widget.aggregation, widget.dimension).toDouble();
          bars.add(
            BarChartRodData(
              y: yAxis,
              color: Constants.textColor.withOpacity(.3),
              width: screenWidth / (widget.timeseries.length * 3),
            ),
          );
        } catch (e) {
          print('Error adding point for snapshot: $e');
        }
      }
    } else {
      final daysSinceStart =
          DateTime.now().toUtc().difference(startDate).inDays;
      for (int i = 0; i < daysSinceStart; i++) {
        bars.add(
          BarChartRodData(
            y: 0,
            color: Constants.textColor.withOpacity(.3),
            width: screenWidth / (daysSinceStart * 3),
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

    return Stack(
      fit: StackFit.expand,
      children: [
        graph,
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThemedText(
                numFmt.format(this.titleData) == "0"
                    ? "-"
                    : numFmt.format(this.titleData),
                variant: TypographyVariant.h2,
                style: TextStyle(
                  color: widget.dimension == DataDimension.cases
                      ? Constants.primaryDarkColor
                      : Constants.accentColor,
                ),
              ),
              ThemedText(
                this.graphTitle,
                variant: TypographyVariant.h4,
                style: TextStyle(
                  color: widget.dimension == DataDimension.cases
                      ? Constants.primaryDarkColor
                      : Constants.accentColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  String get graphTitle => "$graphAggregation $graphDimension";
  String get graphAggregation {
    switch (widget.aggregation) {
      case DataAggregation.total:
        return "Total";
      case DataAggregation.daily:
        return "Daily";
      default:
        return "";
    }
  }

  String get graphDimension {
    switch (widget.dimension) {
      case DataDimension.cases:
        return "cases";
      case DataDimension.deaths:
        return "deaths";
      default:
        return "";
    }
  }
}
