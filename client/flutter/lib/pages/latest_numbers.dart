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
    final S localized = S.of(context);

    return PageScaffold(context,
        title: "Latest Numbers",
        showShareBottomBar: false,
        body: [
          FutureBuilder(
              future: WhoService.getCaseStats(),
              builder: (context, snapshot) {
                final ts = snapshot.hasData ? new DateTime.fromMillisecondsSinceEpoch(snapshot.data['globalStats']['lastUpdated']) : DateTime.now();
                final lastUpd = new DateFormat.yMd().add_jm().format(ts);
                return SliverList(
                    delegate: SliverChildListDelegate([
                  StatCard(
                      title: Text(
                        "GLOBAL CASES",
                        style: name,
                      ),
                      content: snapshot.hasData
                          ? Text(
                              (snapshot.data['globalStats']['cases'] as int)
                                  .toString(),
                              softWrap: true,
                              style: number,
                            )
                          : CupertinoActivityIndicator()),
                  StatCard(
                    title: Text("GLOBAL DEATHS", style: name),
                    content: snapshot.hasData
                        ? Text(
                            (snapshot.data['globalStats']['deaths'] as int)
                                .toString(),
                            softWrap: true,
                            style: number,
                          )
                        : CupertinoActivityIndicator(),
                  ),
                  Container(
                    height: 25,
                  ),
                  Text(
                    snapshot.hasData ? 'Last updated at $lastUpd' : 'Updating...',
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
                      "View live data",
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: title,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
