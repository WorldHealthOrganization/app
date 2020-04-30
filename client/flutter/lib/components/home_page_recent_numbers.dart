import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/components/stat_card.dart';
import 'package:who_app/components/themed_text.dart';

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

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.0,
              children: <Widget>[
                ThemedText(
                  // TODO: localize
                  'Recent Numbers',
                  variant: TypographyVariant.h3,
                ),
                CupertinoButton(
                  padding: EdgeInsets.all(0.0),
                  child: ThemedText(
                    'See all ›',
                    variant: TypographyVariant.button,
                  ),
                  onPressed: () {
                    return Navigator.of(context, rootNavigator: true)
                        .pushNamed('/recent-numbers');
                  },
                ),
              ],
            ),
            Container(
              height: 12.0,
            ),
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
