import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class RecentNumbersGraph extends StatefulWidget {
  const RecentNumbersGraph({
    Key key,
    this.timeseries,
    this.timeseriesKey,
  }) : super(key: key);

  final List timeseries;
  final String timeseriesKey;

  @override
  _RecentNumbersGraphState createState() => _RecentNumbersGraphState();
}

class _RecentNumbersGraphState extends State<RecentNumbersGraph> {
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
    final startDate = DateTime.utc(2020, 1, 1);
    if (widget.timeseries != null) {
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
      final daysSinceStart =
          DateTime.now().toUtc().difference(startDate).inDays;
      for (int i = 0; i < daysSinceStart; i++) {
        spots.add(FlSpot((i * 24).toDouble(), 0.0));
      }
    }
    return spots;
  }
}
