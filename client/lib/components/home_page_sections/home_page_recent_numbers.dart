import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/api/stats_store.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePageRecentNumbers extends StatefulWidget {
  final StatsStore statsStore;
  final RouteLink link;

  const HomePageRecentNumbers(
      {Key key, @required this.statsStore, @required this.link})
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
          _HomeStatsFader(
            statsStore: widget.statsStore,
            numFmt: numFmt,
            link: widget.link,
          ),
        ],
      ),
    );
  }
}

class _HomeStatsFader extends StatefulWidget {
  const _HomeStatsFader({
    Key key,
    @required this.statsStore,
    @required this.numFmt,
    @required this.link,
  }) : super(key: key);

  final NumberFormat numFmt;
  final StatsStore statsStore;
  final RouteLink link;

  @override
  __HomeStatsFaderState createState() => __HomeStatsFaderState();
}

class __HomeStatsFaderState extends State<_HomeStatsFader>
    with SingleTickerProviderStateMixin {
  bool fadeState = true;

  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.addStatusListener((status) {
      if (mounted) {
        setState(() {
          fadeState = !fadeState;
        });
      }
    });
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Button(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        onPressed: widget.link != null
            ? () {
                return widget.link.open(context);
              }
            : null,
        padding: EdgeInsets.zero,
        child: AnimatedCrossFade(
          firstChild: Observer(
            builder: (_) => _HomeStatCard(
              stat: widget.statsStore.countryStats != null &&
                      widget.statsStore.countryDailyCases > 0
                  ? widget.numFmt.format(widget.statsStore.countryDailyCases)
                  : '',
              // TODO: localize
              title: widget.statsStore.countryStats != null &&
                      widget.statsStore.countryDailyCases > 0
                  ? 'National Cases'
                  : '',
            ),
          ),
          duration: Duration(seconds: 1),
          secondChild: Observer(
            builder: (_) => _HomeStatCard(
              stat: widget.statsStore.globalDailyCases != null &&
                      widget.statsStore.globalDailyCases > 0
                  ? widget.numFmt.format(widget.statsStore.globalDailyCases)
                  : '',
              // TODO: localize
              title: widget.statsStore.globalCases != null &&
                      widget.statsStore.globalCases > 0
                  ? 'Global Cases'
                  : '',
            ),
          ),
          crossFadeState:
              fadeState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ));
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
                  stat,
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
                  title,
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
