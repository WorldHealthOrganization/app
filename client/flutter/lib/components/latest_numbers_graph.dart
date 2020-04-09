import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LatestNumbersGraph extends StatelessWidget {
  final lineChartBarData = LineChartBarData(
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
    spots: [
      FlSpot(0, 11656),
      FlSpot(1, 4764),
      FlSpot(2, 16894),
      FlSpot(3, 18093),
      FlSpot(4, 19332),
      FlSpot(5, 17987),
      FlSpot(6, 22559),
      FlSpot(7, 24103),
      FlSpot(8, 26298),
      FlSpot(9, 28103),
      FlSpot(10, 32105),
      FlSpot(11, 33510),
      FlSpot(12, 26493),
      FlSpot(13, 29510),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      axisTitleData: FlAxisTitleData(show: false),
      backgroundColor: Color(0xFF008DC9),
      borderData: FlBorderData(show: false),
      clipToBorder: true,
      gridData: FlGridData(show: false),
      lineBarsData: [
        lineChartBarData,
      ],
      lineTouchData: LineTouchData(enabled: false),
      titlesData: FlTitlesData(show: false),
    ));
  }
}
