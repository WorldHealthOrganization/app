import 'package:flutter/cupertino.dart';
import 'package:who_app/components/learn_page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      showHeader: false,
      body: [
        LearnPageHeader(),
      ],
    );
  }
}
