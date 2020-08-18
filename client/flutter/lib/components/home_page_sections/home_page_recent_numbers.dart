import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePageRecentNumbers extends StatefulWidget {
  final StatsStore statsStore;

  const HomePageRecentNumbers({Key key, @required this.statsStore})
      : super(key: key);

  @override
  _HomePageRecentNumbersState createState() => _HomePageRecentNumbersState();
}

class _HomePageRecentNumbersState extends State<HomePageRecentNumbers> {
  @override
  void initState() {
    super.initState();
    widget.statsStore.update();
  }

  @override
  Widget build(BuildContext context) {
    final numFmt = NumberFormat.decimalPattern();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Observer(
            builder: (ctx) => _HomeStatCard(
              stat: widget.statsStore.globalCases != null &&
                      widget.statsStore.globalCases > 0
                  ? numFmt.format(widget.statsStore.globalCases)
                  : '',
              // TODO: localize
              title: widget.statsStore.globalCases != null &&
                      widget.statsStore.globalCases > 0
                  ? 'Global Cases'
                  : '',
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeStatCard extends StatelessWidget {
  final String stat;
  final String title;

  const _HomeStatCard({
    @required this.stat,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/svg/undraw-home-statcard-bg.svg'),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Constants.primaryDarkColor.withOpacity(0.15),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ThemedText(
                  this.stat,
                  variant: TypographyVariant.h2,
                  softWrap: true,
                  style: TextStyle(
                    color: Constants.primaryDarkColor,
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
                Container(
                  height: 4.0,
                ),
                ThemedText(
                  this.title,
                  variant: TypographyVariant.button,
                  style: TextStyle(
                    color: Constants.primaryDarkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
