import 'package:flutter/cupertino.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';

class PageScaffold extends StatelessWidget {

  PageScaffold({@required this.title, @required this.body});

  final String title;
  List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        PageHeader(this.title),
        ...body
      ],
    );
  }
}