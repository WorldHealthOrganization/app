import './back_arrow.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  final EdgeInsets padding;
  final bool showBackButton;

  PageHeader(
      {@required this.title,
      this.subtitle = "COVID-19 App",
      this.padding = EdgeInsets.zero,
      this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(background: _buildHeader());
  }

  SafeArea _buildHeader() {
    List<Widget> headerItems = [
      this.showBackButton ? _buildBackArrow() : null,
      Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              child: Text(this.title,
                  textScaleFactor: 1.8,
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 4),
            Text(this.subtitle,
                textScaleFactor: 1.0,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      SizedBox(width: 5),
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

  Widget _buildBackArrow() {
    return BackButton();
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: BackArrow(),
      onPressed: () => Navigator.pop(context),
    );
  }
}
