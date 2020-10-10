import 'package:flutter/cupertino.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class PermissionRequestPage extends StatelessWidget {
  final String pageTitle;
  final String pageDescription;
  final String buttonTitle;
  final String backgroundImageSrc;
  final VoidCallback onGrantPermission;
  final VoidCallback onSkip;

  const PermissionRequestPage(
      {Key key,
      @required this.pageTitle,
      this.pageDescription = '',
      @required this.buttonTitle,
      @required this.onGrantPermission,
      @required this.onSkip,
      @required this.backgroundImageSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(1, -0.3),
            child: Image.asset(
              backgroundImageSrc,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                          Semantics(
                            header: true,
                            container: true,
                            child: Text(
                              pageTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xff1A458E),
                                letterSpacing:
                                    -0.5, //TODO: ADD FONT AND REMOVE THIS LINE
                                height: 1.2,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Semantics(
                            container: true,
                            child: Text(
                              pageDescription,
                              style: TextStyle(
                                color: Constants.textColor,
                                height: 1.4,
                                fontSize: 16,
                              ),
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
                      PageButton(Constants.whoBackgroundBlueColor, buttonTitle,
                          onGrantPermission,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalPadding: 12,
                          borderRadius: 35,
                          titleStyle: ThemedText.styleForVariant(
                                  TypographyVariant.button)
                              .merge(TextStyle(color: CupertinoColors.white))),
                      Button(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          S.of(context).commonPermissionRequestPageButtonSkip,
                          style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 18,
                              letterSpacing: Constants.buttonTextSpacing),
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
