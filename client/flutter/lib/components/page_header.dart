import 'package:WHOFlutter/components/back_arrow.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  final BuildContext context;
  final EdgeInsets padding;
  final bool showBackButton;

  PageHeader(this.context,
      {@required this.title,
      this.subtitle = "WHO Coronavirus App",
      this.padding = EdgeInsets.zero,
      this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(background: _buildHeader());
  }

  SafeArea _buildHeader() {
    List<Widget> headerItems = [
      this.showBackButton ? _buildBackArrow() : null,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.title,
              textScaleFactor: 1.8,
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(this.subtitle,
              textScaleFactor: 1.0,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
      Image.asset('assets/images/mark.png', width: 75),
    ];
    headerItems.removeWhere((element) => element == null);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: headerItems),
      ),
    );
  }

  GestureDetector _buildBackArrow() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(this.context),
      child: BackArrow(),
    );
  }
}
