import 'package:WHOFlutter/components/back_arrow.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final EdgeInsets padding;
  final bool showBackButton;
  
  const PageHeader(
      {@required this.title,
      this.subtitle = "WHO Coronavirus App",
      this.padding = EdgeInsets.zero,
      this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(background: _buildHeader(context));
  }

  SafeArea _buildHeader(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool useCompactLayout = width < 340;

    final List<Widget> headerItems = [
      if (showBackButton) _buildBackArrow(context),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.title,
              textScaleFactor: 1.8,
              style: TextStyle(
                height: 1.1,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              this.subtitle,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      Image.asset('assets/images/mark.png', width: useCompactLayout ? 55 : 75),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: headerItems,
        ),
      ),
    );
  }

  Widget _buildBackArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: BackArrow(),
      ),
    );
  }
}
