import './back_arrow.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  final EdgeInsets padding;
  final bool showBackButton;
  final bool showLogo;

  PageHeader({
    @required this.title,
    this.subtitle = "COVID-19",
    this.padding = EdgeInsets.zero,
    this.showBackButton = true,
    this.showLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: HeaderDelagate(
            title: this.title,
            subtitle: this.subtitle,
            padding: this.padding,
            showBackButton: this.showBackButton,
            showLogo: this.showLogo));
  }
}

class HeaderDelagate extends SliverPersistentHeaderDelegate {

  final double maxHeight = 120.0;
  final double minHeight = 80.0;

  final String title;
  final String subtitle;

  final EdgeInsets padding;
  final bool showBackButton;
  final bool showLogo;

  HeaderDelagate({
    @required this.title,
    @required this.subtitle,
    @required this.padding,
    @required this.showBackButton,
    @required this.showLogo,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final double currentHeight = constraints.maxHeight;
      return _buildHeader(currentHeight);
    });
  }

  Widget _buildHeader(double currentHeight) {
    List<Widget> headerItems = [
      if (this.showBackButton) BackArrow(),
      
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.title,
              textScaleFactor: 1.8,
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          if(this.minHeight< currentHeight-20) Text(this.subtitle,
              textScaleFactor: 1.0,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
      Expanded(
        child: Container(),
      ),
      showLogo && this.minHeight<currentHeight -20 ? Image.asset('assets/images/mark.png', width: 75) : Container(),
    ];
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: headerItems),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => this.maxHeight;

  @override
  double get minExtent => this.minHeight;
}
