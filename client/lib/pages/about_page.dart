import 'dart:io';
import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/menu_list_tile.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/generated/build.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:who_app/main.dart';
import 'package:who_app/pages/license_page.dart' as who;
import 'package:who_app/pages/main_pages/routes.dart';
import 'package:yaml/yaml.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final versionString = packageInfo != null
        ? S.of(context).commonWorldHealthOrganizationCoronavirusAppVersion(
            packageInfo.version, packageInfo.buildNumber)
        : null;

    final copyrightString = S
        .of(context)
        .commonWorldHealthOrganizationCoronavirusCopyright(DateTime.now().year);

    Future<void> _openTermsOfService(BuildContext context) async {
      final url = S.of(context).aboutPageTermsOfServiceLinkUrl;
      await launchUrl(url);
      await FirebaseAnalytics().logEvent(name: 'TermsOfService');
    }

    Future<void> _openPrivacyPolicy(BuildContext context) async {
      final url = S.of(context).legalLandingPagePrivacyPolicyLinkUrl;
      await launchUrl(url);
      await FirebaseAnalytics().logEvent(name: 'PrivacyPolicy');
    }

    String _buildInfoText(BuildContext bc) {
      return [
        'Debug Info:',
        'Pkg info: ${packageInfo?.appName}, ${packageInfo?.packageName}, ${packageInfo?.version}, ${packageInfo?.buildNumber}',
        'Git commit: ${BuildInfo.GIT_SHA}',
        'Platform locale: ${Platform.localeName}',
        'Platform version: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
        'Flutter locale: ${Localizations.localeOf(bc).toString()}',
        'Flutter version: ${BuildInfo.FLUTTER_VERSION}',
      ].join('\n');
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
      appBarColor: Colors.white,
      color: Colors.white,
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
                padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: ThemedText(
                  S.of(context).aboutPageBuiltByCreditText(
                        copyrightString,
                        versionString,
                      ),
                  variant: TypographyVariant.body,
                ),
              ),
              Container(
                color: CupertinoColors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/credits.yaml'),
                  builder: (context, snapshot) {
                    dynamic yaml =
                        loadYaml(snapshot.data ?? 'team: []\nsupporters: []');
                    var team = List<String>.from(yaml['team'] as YamlList);
                    // Sort order is random A-Z or Z-A.
                    final orderSign = Random.secure().nextBool() ? 1 : -1;
                    final strategyTeam = [
                      'Advay Mengle',
                      'Bob Lee',
                      'Bruno Bowden',
                      'Daniel Kraft',
                      'David Kaneda',
                      'Dean Hachamovitch',
                      'Hunter Spinks',
                      'Karen Wong',
                    ];
                    strategyTeam.sort((x, y) => (orderSign *
                        x.toLowerCase().compareTo(y.toLowerCase())));
                    strategyTeam.forEach((x) => team.remove(x));
                    team.sort(
                        (x, y) => x.toLowerCase().compareTo(y.toLowerCase()));
                    var teamNames = S.of(context).aboutPageThanksToText(
                        '${strategyTeam.join(', ')}; and ${team.join(', ')}');
                    return ThemedText(
                      teamNames,
                      variant: TypographyVariant.body,
                      softWrap: true,
                    );
                  },
                ),
              ),
              Container(
                  color: CupertinoColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Button(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 24,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.copy,
                                    size: 14,
                                  ),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: _buildInfoText(context)));
                                  },
                                ),
                                ThemedText(
                                  _buildInfoText(context),
                                  variant: TypographyVariant.bodySmall,
                                )
                              ])))
            ],
          ),
        ),
      ],
      title: S.of(context).aboutPageTitle,
      heroTag: HeroTags.settings,
    );
  }
}
