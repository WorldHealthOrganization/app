import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/menu_list_tile.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_app/main.dart';
import 'package:who_app/pages/license_page.dart' as who;
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

    Future<void> _openTermsOfService(BuildContext context) async {
      final String url = S.of(context).aboutPageTermsOfServiceLinkUrl;
      await launch(url);
      await FirebaseAnalytics().logEvent(name: 'TermsOfService');
    }

    Future<void> _openPrivacyPolicy(BuildContext context) async {
      final String url = S.of(context).legalLandingPagePrivacyPolicyLinkUrl;
      await launch(url);
      await FirebaseAnalytics().logEvent(name: 'PrivacyPolicy');
    }

    Future<void> _openLicenses(BuildContext context) async {
      // Logs the page switch as it happens while avoiding any delay caused
      // by logging.
      // ignore: unawaited_futures
      FirebaseAnalytics().logEvent(name: 'ViewLicenses');
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => who.LicensePage()),
      );
    }

    // TODO add divider theme to ThemeData once we've switched to a MaterialApp
    Widget _divider() =>
        Divider(height: 1, thickness: 1, color: Color(0xFFC9CDD6));

    return PageScaffold(
      appBarColor: Constants.backgroundColor,
      body: [
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              MenuListTile(
                title: S.of(context).aboutPageTermsOfServiceLinkText,
                onTap: () => _openTermsOfService(context),
              ),
              _divider(),
              MenuListTile(
                title: S.of(context).aboutPagePrivacyPolicyLinkText,
                onTap: () => _openPrivacyPolicy(context),
              ),
              _divider(),
              MenuListTile(
                title: S.of(context).aboutPageViewLicensesLinkText,
                onTap: () => _openLicenses(context),
              ),
              _divider(),
              Container(
                color: CupertinoColors.white,
                padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
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
