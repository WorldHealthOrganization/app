import 'package:WHOFlutter/api/who_service.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/components/latest_numbers_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:WHOFlutter/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const number =
    TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold);
const loadingStyle = TextStyle(
  color: Colors.white,
  fontSize: 36,
);
const name = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

const header =
    TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);

class LatestNumbers extends StatefulWidget {
  @override
  _LatestNumbersState createState() => _LatestNumbersState();
}

class _LatestNumbersState extends State<LatestNumbers> {
  final NumberFormat numFmt = NumberFormat.decimalPattern();

  _launchStatsDashboard(BuildContext context) async {
    var url = S.of(context).homePagePageButtonLatestNumbersUrl;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Map globalStats;
  String lastUpdated;

  @override
  void initState() {
    super.initState();
    initStats();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: S.of(context).latestNumbersPageTitle,
        showShareBottomBar: false,
        announceRouteManually: true,
        body: [
          CupertinoSliverRefreshControl(
            refreshIndicatorExtent: 100,
            refreshTriggerPullDistance: 100,
            builder:
                (context, RefreshIndicatorMode refreshIndicatorMode, a, b, c) {
              double topPadding = a > 25 ? a : 25.0;
              var loadingIndicator = Padding(
                padding: EdgeInsets.only(top: topPadding - 25),
                child: CupertinoActivityIndicator(),
              );
              switch (refreshIndicatorMode) {
                case RefreshIndicatorMode.drag:
                  return a > 10
                      ? Padding(
                          padding: EdgeInsets.only(top: topPadding - 25),
                          child: Icon(
                            Icons.arrow_downward,
                            color: CupertinoColors.systemGrey,
                          ),
                        )
                      : Container();
                  break;
                case RefreshIndicatorMode.refresh:
                  return loadingIndicator;
                case RefreshIndicatorMode.armed:
                  return loadingIndicator;
                default:
                  return Container();
              }
            },
            onRefresh: () async {
              await initStats();
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              StatCard(
                  background: LatestNumbersGraph(
                    timeseries: globalStats['timeseries'],
                    timeseriesKey: 'dailyCases',
                  ),
                  title: Text(
                    S.of(context).latestNumbersPageGlobalCasesTitle,
                    style: name,
                  ),
                  content: Text(
                    globalStats['cases'] != null
                        ? numFmt.format(globalStats['cases'])
                        : '-',
                    softWrap: true,
                    style: globalStats['cases'] != null ? number : loadingStyle,
                    textAlign: TextAlign.left,
                  )),
              StatCard(
                background: LatestNumbersGraph(
                  timeseries: globalStats['timeseries'],
                  timeseriesKey: 'dailyDeaths',
                ),
                title: Text(S.of(context).latestNumbersPageGlobalDeaths,
                    style: name),
                content: Text(
                  globalStats['deaths'] != null
                      ? numFmt.format(globalStats['deaths'])
                      : '-',
                  softWrap: true,
                  style: globalStats['deaths'] != null ? number : loadingStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 25,
              ),
              Text(
                this.lastUpdated ?? S.of(context).latestNumbersPageUpdating,
                style: TextStyle(color: Color(0xff26354E)),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 10,
              ),
              Text(
                globalStats['attribution'] != null
                    ? 'Source: ${globalStats['attribution']}'
                    : '',
                style: TextStyle(color: Color(0xff26354E)),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 24,
                  right: 24,
                ),
                child: PageButton(
                  Color(0xFF3D8AC4),
                  S.of(context).latestNumbersPageViewLiveData,
                  () => _launchStatsDashboard(context),
                  verticalPadding: 24,
                  borderRadius: 36,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              )
            ]),
          ),
        ]);
  }

  void initStats() async {
    setState(() {
      this.globalStats = Map();
    });

    Map snapshot = await WhoService.getCaseStats();
    final globalStats = snapshot['globalStats'];

    final ts = globalStats != null
        ? DateTime.fromMillisecondsSinceEpoch(globalStats['lastUpdated'])
        : DateTime.now();
    final lastUpd = DateFormat.MMMMEEEEd().add_jm().format(ts);

    setState(() {
      this.globalStats = globalStats;
      this.lastUpdated = S.of(context).latestNumbersPageLastUpdated(lastUpd);
    });
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    @required this.title,
    @required this.content,
    @required this.background,
  });
  final Text title;
  final Widget content;
  final Widget background;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 6),
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: background,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: title,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: content,
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
