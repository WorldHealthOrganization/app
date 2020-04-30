import 'package:flutter/cupertino.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/home_page_header.dart';
import 'package:who_app/components/home_page_information_card.dart';
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
        HomePageRecentNumbers(),
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
        )
      ],
    );
  }
}
