import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_app/main.dart';
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:yaml/yaml.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String versionString = packageInfo != null
        ? S.of(context).commonWorldHealthOrganizationCoronavirusAppVersion(
            packageInfo.version, packageInfo.buildNumber)
        : null;

    final String copyrightString = S
        .of(context)
        .commonWorldHealthOrganizationCoronavirusCopyright(DateTime.now().year);

    return PageScaffold(
      body: [
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Container(
                color: CupertinoColors.white,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text.rich(
                  TextSpan(
                      style: TextStyle(color: CupertinoColors.black),
                      children: [
                        LinkTextSpan(
                            text: S.of(context).aboutPageTermsOfServiceLinkText,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: CupertinoColors.activeBlue),
                            url: S.of(context).aboutPageTermsOfServiceLinkUrl,
                            onLinkTap: (v) {
                              FirebaseAnalytics()
                                  .logEvent(name: 'TermsOfService');
                              launch(v);
                            }),
                        TextSpan(text: "  —  "),
                        LinkTextSpan(
                            text: S.of(context).aboutPagePrivacyPolicyLinkText,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: CupertinoColors.activeBlue),
                            url: S.of(context).aboutPagetermsOfServiceLinkUrl,
                            onLinkTap: (v) {
                              FirebaseAnalytics()
                                  .logEvent(name: 'PrivacyPolicy');
                              launch(v);
                            }),
                        TextSpan(text: "  —  "),
                        LinkTextSpan(
                          text: S.of(context).aboutPageViewLicensesLinkText,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: CupertinoColors.activeBlue),
                          onLinkTap: (v) {
                            FirebaseAnalytics().logEvent(name: 'ViewLicenses');
                            showLicensePage(context: context);
                          },
                        ),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                color: CupertinoColors.white,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: ThemedText(
                  S.of(context).aboutPageBuiltByCreditText(
                      copyrightString, versionString),
                  variant: TypographyVariant.body,
                ),
              ),
              Container(
                color: CupertinoColors.white,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/credits.yaml'),
                  builder: (context, snapshot) {
                    dynamic yaml =
                        loadYaml(snapshot.data ?? 'team: []\nsupporters: []');
                    var team = List<String>.from(yaml['team'] as YamlList);
                    team.sort(
                        (x, y) => (x.toLowerCase().compareTo(y.toLowerCase())));
                    final founders = [
                      "Bruno Bowden",
                      "Daniel Kraft",
                      "Dean Hachamovitch"
                    ];
                    founders.forEach((x) => team.remove(x));
                    team.insertAll(0, founders);
                    var teamNames =
                        S.of(context).aboutPageThanksToText(team.join(", "));
                    return ThemedText(
                      teamNames,
                      variant: TypographyVariant.body,
                      softWrap: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      title: S.of(context).aboutPageTitle,
      heroTag: HeroTags.settings,
    );
  }
}
