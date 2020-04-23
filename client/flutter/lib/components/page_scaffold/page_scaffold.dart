import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';

class PageScaffold extends StatelessWidget {
  PageScaffold(
      {@required this.body,
      this.headerChildren,
      this.title = "",
      this.roundedHeader = false,
      this.headerBackgroundColor = Colors.white});

  /// Title only applies when roundedHeader is false
  final String title;

  final bool roundedHeader;

  /// Header children only applies when header is rounded
  final List<Widget> headerChildren;

  /// The header's background color
  final Color headerBackgroundColor;

  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        this.roundedHeader
            ? RoundedPageHeader(
                backgroundColor: this.headerBackgroundColor,
                children: this.headerChildren,
              )
            : PageHeader(
                this.title,
                backgroundColor: this.headerBackgroundColor,
              ),
        ...body,
      ],
    );
  }
}
