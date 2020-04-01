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
    return SliverAppBar(
      leading: Container(),
      expandedHeight: 120,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(background:_buildHeader()),
    );
  }

  Widget _buildHeader() {
    List<Widget> headerItems = [
      if (this.showBackButton) BackArrow(),
      
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FittedBox(
//              fit:BoxFit.fitWidth,
              child: Text(this.title,
                  textScaleFactor: 1.8,
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 4),
            FittedBox(
              child: Text(this.subtitle,
                  textScaleFactor: 1.0,
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),

      if(this.showLogo)Image.asset('assets/images/mark.png', width: 75) else Container(width: 0,height: 0,)
    ];
    return Material(
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

}