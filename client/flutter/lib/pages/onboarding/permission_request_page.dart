import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class PermissionRequestPage extends StatelessWidget {
  final String pageTitle;
  final String pageDescription;
  final String buttonTitle;
  final String backgroundImageSrc;
  final VoidCallback onGrantPermission;
  final VoidCallback onSkip;

  const PermissionRequestPage({
    Key key,
      @required this.pageTitle,
      this.pageDescription = "",
      @required this.buttonTitle,
      @required this.onGrantPermission,
      @required this.onSkip,
      @required this.backgroundImageSrc
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(1, -0.3),
            child: Image.asset(
              this.backgroundImageSrc,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment(0, 0.8),
                    child: ConstrainedBox(
                      // Allows the titles of adjacent pages to stay vertically
                      // aligned while allowing the widget to grow to prevent
                      // an overflow
                      constraints: BoxConstraints(minHeight: 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            this.pageTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xff1A458E),
                              letterSpacing: -0.5,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            this.pageDescription,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff26354E),
                              height: 1.2,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Material(
                        shape: StadiumBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: PageButton(
                          Color(0xff008DC9),
                          buttonTitle,
                          onGrantPermission,
                          titleStyle: TextStyle(fontWeight: FontWeight.w600),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalPadding: 24,
                          borderRadius: 35,
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          S.of(context).commonPermissionRequestPageButtonSkip,
                          style: TextStyle(
                            color: Color(0xFF6E7691),
                            fontSize: 18,
                          ),
                        ),
                        onPressed: onSkip,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
