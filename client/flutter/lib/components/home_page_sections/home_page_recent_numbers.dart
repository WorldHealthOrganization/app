import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/components/stat_card.dart';

class HomePageRecentNumbers extends StatefulWidget {
  @override
  _HomePageRecentNumbersState createState() => _HomePageRecentNumbersState();
}

class _HomePageRecentNumbersState extends State<HomePageRecentNumbers> {
  int globalCaseCount;
  int globalDeathCount;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    final numFmt = NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StatCard(
            stat: this.globalCaseCount != null && this.globalCaseCount > 0
                ? numFmt.format(this.globalCaseCount)
                : '-',
            // TODO: localize
            title: 'Global Cases',
          ),
          Container(
            height: 12.0,
          ),
          StatCard(
            stat: this.globalDeathCount != null && this.globalDeathCount > 0
                ? numFmt.format(this.globalDeathCount)
                : '-',
            // TODO: localize
            title: 'Global Deaths',
          ),
        ],
      ),
    );
  }

  void fetchStats() async {
    Map statsResponse = await WhoService.getCaseStats();
    final globalStats = statsResponse['globalStats'];

    if (globalStats != null) {
      setState(() {
        this.globalCaseCount = globalStats['cases'];
        this.globalDeathCount = globalStats['deaths'];
      });
    }
  }
}
