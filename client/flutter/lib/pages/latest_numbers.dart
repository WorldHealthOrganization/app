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
  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
        title: "Latest Numbers",
        showShareBottomBar: false,
        body: [
          FutureBuilder(
              future: WhoService.getCaseStats(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: CupertinoActivityIndicator(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Updating...",
                        textAlign: TextAlign.center,
                      )
                    ]),
                  );
                } else if (!snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 15,),
                       Text(
                        "No data returned",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ViewLiveDataButton(),
                      ),
                    ]),
                  );
                } else if (true) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 15,),
                       Text(
                        "Error connecting",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ViewLiveDataButton(),
                      ),
                     
                    ]),
                  );
                } else {
                  final globalStats = snapshot.data['globalStats'];
                  final ts = DateTime.fromMillisecondsSinceEpoch(
                      globalStats['lastUpdated']);
                  final lastUpd = DateFormat.MMMMEEEEd().add_jm().format(ts);
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    StatCard(
                        title: Text(
                          "GLOBAL CASES",
                          style: name,
                        ),
                        content: Text(
                          globalStats['cases'].toString() ?? "-",
                          softWrap: true,
                          style: globalStats['cases'] != null
                              ? number
                              : loadingStyle,
                          textAlign: TextAlign.left,
                        )),
                    StatCard(
                      title: Text("GLOBAL DEATHS", style: name),
                      content: Text(
                        globalStats['deaths'].toString() ?? '-',
                        softWrap: true,
                        style: globalStats['deaths'] != null
                            ? number
                            : loadingStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      height: 25,
                    ),
                    Text(
                      'Last updated $lastUpd',
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
                      child: ViewLiveDataButton(),
                    )
                  ]));
                }
              }),
        ]);
  }
}

class ViewLiveDataButton extends StatelessWidget {
  _launchStatsDashboard(BuildContext context) async {
    var url = S.of(context).homePagePageButtonLatestNumbersUrl;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageButton(
      Color(0xff1A458E),
      "View live data",
      () {
        return _launchStatsDashboard(context);
      },
      mainAxisAlignment: MainAxisAlignment.start,
    );
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
