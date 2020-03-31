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
      child: Stack(
        children: <Widget>[
          Center(child: Image.asset(this.backgroundImageSrc, fit: BoxFit.fitWidth, alignment: Alignment.center)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 18, top: 30),
                  child: Column(
                    children: <Widget>[
                      Text(this.pageTitle, style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xff050C1D)), textScaleFactor: 2.5,),
                      SizedBox(height: 18,),
                      Text(this.pageDescription, style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xff26354E)), textScaleFactor: 1.2,)
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    PageButton(
                      Color(0xff3b8bc4),
                      buttonTitle,
                      onGrantPermission,
                      titleStyle: TextStyle(),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalPadding: 24,
                      borderRadius: 35,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        S.of(context).commonPermissionRequestPageButtonSkip,
                        style: TextStyle(color: Color(0xffC9CDD6)),
                        textScaleFactor: 1.3,
                      ),
                      onPressed: onSkip,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
