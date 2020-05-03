import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/home_page_sections/home_page_donate.dart';
import 'package:who_app/components/home_page_sections/home_page_header.dart';
import 'package:who_app/components/home_page_sections/home_page_information_card.dart';
import 'package:who_app/components/home_page_sections/home_page_protect_yourself.dart';
import 'package:who_app/components/home_page_sections/home_page_recent_numbers.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      showHeader: false,
      color: Constants.greyBackgroundColor,
      body: [
        _HomePageSection(
          content: HomePageHeader(HeaderType.ProtectYourself),
        ),
        _HomePageSection(
          padding: EdgeInsets.only(top: 56.0),
          header: _HomePageSectionHeader(
            // TODO: localize
            title: 'Recent Numbers',
            linkText: 'See all ›',
            link: RouteLink.fromUri('/recent-numbers'),
          ),
          content: HomePageRecentNumbers(),
        ),
        _HomePageSection(
          padding: EdgeInsets.only(top: 44.0),
          header: _HomePageSectionHeader(
            // TODO: Localize
            title: 'Protect Yourself',
            linkText: 'Learn more ›',
            link: RouteLink.fromUri('/protect-yourself'),
          ),
          content: HomePageProtectYourself(
            dataSource: FactContent.protectYourself,
          ),
        ),
        _HomePageSection(
          padding: EdgeInsets.only(top: 72.0),
          content: HomePageInformationCard(
            title: 'Get the Facts',
            subtitle:
                'Spraying alcohol or chlorine all over your body does not kill the new coronavirus.',
            buttonText: 'Learn more',
            link: RouteLink.fromUri('/get-the-facts'),
          ),
        ),
        _HomePageSection(
          padding: EdgeInsets.only(top: 64.0),
          content: HomePageDonate(),
        ),
      ],
    );
  }
}

class _HomePageSection extends StatelessWidget {
  final Widget content;
  final Widget header;
  final EdgeInsets padding;

  const _HomePageSection({
    @required this.content,
    this.header,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: this.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (this.header != null) this.header,
            this.content
          ],
        ),
      ),
    );
  }
}

class _HomePageSectionHeader extends StatelessWidget {
  final String title;
  final String linkText;
  final RouteLink link;

  const _HomePageSectionHeader({
    @required this.title,
    @required this.linkText,
    @required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16.0,
        children: <Widget>[
          ThemedText(
            this.title,
            variant: TypographyVariant.h3,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: ThemedText(
              this.linkText,
              variant: TypographyVariant.button,
              style: TextStyle(
                color: Constants.neutralTextLightColor,
              ),
            ),
            onPressed: () {
              return Navigator.of(context, rootNavigator: true)
                  .pushNamed(this.link.route, arguments: this.link.args);
            },
          ),
        ],
      ),
    );
  }
}
