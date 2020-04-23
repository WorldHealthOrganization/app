import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/constants.dart';

class PageHeader extends StatelessWidget {
  PageHeader(
    this.title, {
    this.backgroundColor = Colors.white,
  });
  final String title;

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: this.backgroundColor,
      largeTitle: Text(
        this.title,
        style: TextStyle(color: Constants.primaryDark),
      ),
    );
  }
}

class RoundedPageHeader extends StatelessWidget {
  /// The children to be displayed within the header
  final List<Widget> children;

  /// The color of the header
  final Color backgroundColor;

  RoundedPageHeader({
    @required this.children,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SafeArea(
          child: Column(
            children: this.children,
          ),
        ),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: BorderRadius.vertical(
              bottom:
                  Radius.elliptical(MediaQuery.of(context).size.width, 100.0)),
        ),
      ),
    );
  }
}

