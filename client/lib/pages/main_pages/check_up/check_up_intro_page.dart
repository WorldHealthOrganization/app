import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

import '../../about_page.dart';

class CheckUpIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inHomePage = !ModalRoute.of(context).canPop;
    return PageScaffold(
      showBackButton: !inHomePage,
      color: CupertinoColors.white,
      // TODO: localize
      title: 'Check-Up',
      header: inHomePage
          ? SliverSafeArea(
              top: true,
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 36, 16, 20),
                  // TODO: localize
                  child: PageHeader.buildTitle(
                    'Check-Up',
                    textStyle:
                        ThemedText.styleForVariant(TypographyVariant.title)
                            .merge(
                      TextStyle(color: Constants.primaryDarkColor),
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: <Widget>[
        if (!inHomePage) SliverToBoxAdapter(child: SizedBox(height: 24)),
        _buildBody(context)
      ],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        ..._optionWidgets(context),
        submitWidget(context),
      ]));

  List<Widget> _optionWidgets(BuildContext context) {
    // TODO: localize everything
    return <Widget>[
      Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 60,
            bottom: 20,
            top: 0,
          ),
          child: ThemedText(
            'You should know...',
            variant: TypographyVariant.body,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      _ListItem(
          title:
              'Your answers will not be shared with WHO or others without your permission.',
          iconName: 'safe'),
      _ListItem(
        title:
            'By using this tool, you agree to its terms and that WHO will not be liable for any harm relating to your use.',
        iconName: 'check',
      ),
      _ListItem(
        title:
            'Information provided by this tool does not constitute medical advise and should not be used to diagnose or treat medical conditions.',
        iconName: 'medical',
        extra: CupertinoButton(
          padding: EdgeInsets.zero,
          child: ThemedText(
            'See terms ›',
            variant: TypographyVariant.body,
            style: TextStyle(
              color: Constants.whoBackgroundBlueColor,
            ),
          ),
          onPressed: () {
            return AboutPage.openTermsOfService(context);
          },
        ),
      ),
    ];
  }

  Widget submitWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 24,
        right: 24,
        bottom: 48,
      ),
      child: PageButton(
        Constants.whoBackgroundBlueColor,
        'Get Started',
        () => Navigator.of(context, rootNavigator: true)
            .pushNamed('/symptom-checker-survey'),
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalPadding: 12,
        borderRadius: 500,
        titleStyle: ThemedText.styleForVariant(TypographyVariant.button)
            .merge(TextStyle(color: CupertinoColors.white)),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconName;
  final Widget extra;

  _ListItem(
      {@required this.title,
      @required this.iconName,
      this.subtitle,
      this.extra});

  @override
  Widget build(BuildContext context) {
    final iconSize = 24 * MediaQuery.textScaleFactorOf(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 60,
        bottom: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/streamline-sc-start-${iconName}.svg',
            color: Constants.whoBackgroundBlueColor,
            width: iconSize,
            height: iconSize,
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                ThemedText(title, variant: TypographyVariant.body),
                if (extra != null) extra,
              ]))
        ],
      ),
    );
  }
}
