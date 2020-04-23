import 'package:flutter/cupertino.dart';

class PageHeader extends StatelessWidget {

  PageHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(this.title),
    );
  }
}