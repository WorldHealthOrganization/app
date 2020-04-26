import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/cupertino.dart';

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
            isCurved: false,
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
    final startDate = DateTime.utc(2020, 1, 9);
    if (_showData && widget.timeseries != null) {
      for (var snapshot in widget.timeseries) {
        try {
          var xAxis = DateTime.fromMillisecondsSinceEpoch(snapshot['epochMsec'],
                  isUtc: true)
              .difference(startDate)
              .inHours
              .toDouble();
          var yAxis = snapshot[widget.timeseriesKey].toDouble();
          spots.add(FlSpot(xAxis, yAxis));
        } catch (e) {
          print('Error adding point for snapshot: $e');
        }
      }
    } else {
      // TODO: fix animation
      // This attempts to create the line with the same number of data points as the real data for the animation.
      // But, the animation still goes from right to left as if it's starting with no data points...
      final daysSinceStart =
          DateTime.now().toUtc().difference(startDate).inDays;
      for (double i = 0.0; i < daysSinceStart; i += 1.0) {
        spots.add(FlSpot(i, 0.0));
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
