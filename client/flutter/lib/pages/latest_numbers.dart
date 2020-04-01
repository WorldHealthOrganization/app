import 'package:WHOFlutter/api/who_service.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:WHOFlutter/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const number = TextStyle(
  color: Color(0xFFAF2B2B),
  fontSize: 36,
);
const loadingStyle = TextStyle(
  color: Color(0xff26354E),
  fontSize: 36,
);
const name = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
const header =
    TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);

class LatestNumbers extends StatelessWidget {
  _launchStatsDashboard(BuildContext context) async {
    var url = S.of(context).homePagePageButtonLatestNumbersUrl;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
        title: S.of(context).latestNumbersPageTitle,
        showShareBottomBar: false,
        body: [
          FutureBuilder(
              future: WhoService.getCaseStats(),
              builder: (context, snapshot) {
                final hasGlobalStats =
                    snapshot.hasData && snapshot.data['globalStats'] != null;
                final globalStats =
                    hasGlobalStats ? snapshot.data['globalStats'] : null;
                final ts = hasGlobalStats
                    ? DateTime.fromMillisecondsSinceEpoch(
                        globalStats['lastUpdated'])
                    : DateTime.now();
                final numFmt = NumberFormat.decimalPattern();
                final lastUpd = DateFormat.MMMMEEEEd().add_jm().format(ts);
                return SliverList(
                    delegate: SliverChildListDelegate([
                  StatCard(
                      title: Text(
                        S.of(context).latestNumbersPageGlobalCasesTitle,
                        style: name,
                      ),
                      content: Text(
                        hasGlobalStats && globalStats['cases'] != null
                            ? numFmt.format(globalStats['cases'])
                            : '-',
                        softWrap: true,
                        style: hasGlobalStats && globalStats['cases'] != null ? number : loadingStyle,
                        textAlign: TextAlign.left,
                      )),
                  StatCard(
                    title: Text(S.of(context).latestNumbersPageGlobalDeaths, style: name),
                    content: Text(
                      hasGlobalStats && globalStats['deaths'] != null
                          ? numFmt.format(globalStats['deaths'])
                          : '-',
                      softWrap: true,
                      style: hasGlobalStats && globalStats['deaths'] != null ? number : loadingStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 25,
                  ),
                  Text(
                    snapshot.hasData
                        ? S.of(context).latestNumbersPageLastUpdated(lastUpd)
                        : S.of(context).latestNumbersPageUpdating,
                    style: TextStyle(color: Color(0xff26354E)),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    hasGlobalStats && globalStats['attribution'] != null
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
                      Color(0xff1A458E),
                      S.of(context).latestNumbersPageViewLiveData,
                      () {
                        return _launchStatsDashboard(context);
                      },
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  )
                ]));
              }),
        ]);
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    @required this.title,
    @required this.content,
  });
  final Text title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
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
      ),
    );
  }
}
