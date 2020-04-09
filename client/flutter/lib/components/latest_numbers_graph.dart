import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LatestNumbersGraph extends StatefulWidget {
  const LatestNumbersGraph({
    Key key,
    this.timeseries,
  }) : super(key: key);

  final List timeseries;

  @override
  _LatestNumbersGraphState createState() => _LatestNumbersGraphState();
}

class _LatestNumbersGraphState extends State<LatestNumbersGraph> {
  var _showData = false;

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
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
    ));
  }

  List<FlSpot> _buildSpots() {
    var spots = <FlSpot>[];
    double xAxis = 0.0;
    if (_showData && widget.timeseries != null) {
      for (var cases in widget.timeseries) {
        spots.add(FlSpot(xAxis, cases));
        xAxis += 1.0;
      }
    } else {
      for (; xAxis < 14.0; xAxis += 1.0) {
        spots.add(FlSpot(xAxis, 0.0));
      }
      if (!_showData && widget.timeseries != null) {
        setState(() {
          _showData = true;
        });
      }
    }
    return spots;
  }
}
