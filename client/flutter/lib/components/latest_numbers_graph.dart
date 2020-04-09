import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LatestNumbersGraph extends StatefulWidget {
  const LatestNumbersGraph({
    Key key,
    this.timeseries,
    this.timeseriesKey,
  }) : super(key: key);

  final List timeseries;
  final String timeseriesKey;

  @override
  _LatestNumbersGraphState createState() => _LatestNumbersGraphState();
}

class _LatestNumbersGraphState extends State<LatestNumbersGraph> {
  var _showData = false;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        axisTitleData: FlAxisTitleData(show: false),
        backgroundColor: Color(0xFF008DC9),
        borderData: FlBorderData(show: false),
        clipToBorder: true,
        gridData: FlGridData(show: false),
        lineBarsData: [
          LineChartBarData(
            aboveBarData: BarAreaData(
              colors: [Color(0xFF008DC9)],
              show: true,
            ),
            barWidth: 0,
            belowBarData: BarAreaData(
              colors: [Color(0xFF6AC7FA)],
              show: true,
            ),
            colors: [Color(0xFF6AC7FA)],
            dotData: FlDotData(show: false),
            isCurved: true,
            spots: _buildSpots(),
          ),
        ],
        lineTouchData: LineTouchData(enabled: false),
        titlesData: FlTitlesData(show: false),
      ),
      swapAnimationDuration: Duration(milliseconds: 750),
    );
  }

  List<FlSpot> _buildSpots() {
    var spots = <FlSpot>[];
    double xAxis = 0.0;
    if (_showData &&
        widget.timeseries != null &&
        widget.timeseries.isNotEmpty) {
      // TODO: do not assume that there is 1 snapshot per day; group snapshots by epochMsec
      // Throw out last day's data since it appears to be partial and adds a misleading downslope
      for (var snapshot
          in widget.timeseries.sublist(0, widget.timeseries.length - 1)) {
        var yAxis = 0.0;
        try {
          yAxis = snapshot[widget.timeseriesKey].toDouble();
        } catch (e) {
          print('Exception casting to double: $e');
        }
        spots.add(FlSpot(xAxis, yAxis));
        xAxis += 1.0;
      }
    } else {
      // TODO: fix animation
      // This attempts to create the line with the same number of data points as the real data for the animation.
      // But, the animation still goes from right to left as if it's starting with no data points...
      final daysSinceStart =
          DateTime.now().difference(DateTime(2020, 1, 9)).inDays;
      for (int i = 0; i < daysSinceStart; i++) {
        spots.add(FlSpot(xAxis, 0.0));
        xAxis += 1.0;
      }
    }
    if (!_showData && widget.timeseries != null) {
      // TODO: find less hacky way to do this
      SchedulerBinding.instance.addPostFrameCallback((timestamp) async {
        await Future.delayed(Duration(milliseconds: 100));
        setState(() {
          _showData = true;
        });
      });
    }
    return spots;
  }
}
