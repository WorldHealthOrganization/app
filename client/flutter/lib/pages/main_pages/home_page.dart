import 'package:flutter/cupertino.dart';
import 'package:who_app/api/content/schema/fact_content.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/home_page_donate.dart';
import 'package:who_app/components/home_page_header.dart';
import 'package:who_app/components/home_page_information_card.dart';
import 'package:who_app/components/home_page_protect_yourself.dart';
import 'package:who_app/components/home_page_recent_numbers.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      showHeader: false,
      color: Constants.greyBackgroundColor,
      body: [
        HomePageHeader(HeaderType.ProtectYourself),
        SliverToBoxAdapter(
            child: Container(
          height: 32.0,
        )),
        HomePageRecentNumbers(),
        SliverToBoxAdapter(
            child: Container(
          height: 20.0,
        )),
        HomePageProtectYourself(
          dataSource: FactContent.protectYourself,
        ),
        SliverToBoxAdapter(
            child: Container(
          height: 48.0,
        )),
        SliverToBoxAdapter(
          // TODO: drive this dynamically
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: HomePageInformationCard(
              buttonText: 'Learn more',
              link: RouteLink.fromUri('/get-the-facts'),
              subtitle:
                  'Spraying alcohol or chlorine all over your body does not kill the new coronavirus.',
              title: 'Get the Facts',
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
          height: 40.0,
        )),
        HomePageDonate(),
      ],
    );
  }
}
