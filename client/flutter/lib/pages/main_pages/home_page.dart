import 'package:flutter/cupertino.dart';
import 'package:who_app/components/home_page_header.dart';
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
      ],
    );
  }
}
