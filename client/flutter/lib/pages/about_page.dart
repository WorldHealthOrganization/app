import 'package:WHOFlutter/components/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:WHOFlutter/main.dart';
import 'package:yaml/yaml.dart';

class AboutPage extends StatelessWidget {
  final String versionString = packageInfo != null
      ? 'Version ${packageInfo.version} (${packageInfo.buildNumber})\n'
      : null;
  final String copyrightString = '© 2020 WHO';

  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
        body: [
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
                  LinkTextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                      url:
                          "https://whocoronavirus.org/terms",
                      onLinkTap: (v) => launch(v)),
                  TextSpan(text: "  —  "),
                  LinkTextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                      url:
                          "https://whocoronavirus.org/privacy",
                      onLinkTap: (v) => launch(v)),
                  TextSpan(text: "  —  "),
                  LinkTextSpan(
                      text: "View Licenses",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                      onLinkTap: (v) => showLicensePage(context: context)),
                ]),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                "$copyrightString\n\n$versionString\nBuilt by the WHO COVID-19 App Collective.",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context).loadString('assets/credits.yaml'),
                    builder: (context, snapshot) {
                      dynamic yaml = loadYaml(snapshot.data ?? 'team: []\nsupporters: []');
                      var team = List<String>.from(yaml['team'] as YamlList);
                      team.sort((x, y) => (x.toLowerCase().compareTo(y.toLowerCase())));
                      final founders = ["Bruno Bowden", "Daniel Kraft", "Dean Hachamovitch"];
                      founders.forEach((x) => team.remove(x));
                      team.insertAll(0, founders);
                      var teamNames = "Thanks to: " + team.join(", ");
                      return Text(
                        teamNames,
                        softWrap: true,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      );
                    })),
          ])),
        ],
        title: "About");
  }
}
