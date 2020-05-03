import 'package:flutter/cupertino.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class LearnPagePromo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final RouteLink link;

  const LearnPagePromo(
      {Key key, this.title, this.subtitle, this.buttonText, this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: isLight(context)
          ? Color(0xffD5F5FD)
          : CupertinoColors.darkBackgroundGray,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ThemedText(
              title,
              variant: TypographyVariant.h3,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme(context).primaryDarkColor,
              ),
            ),
            ThemedText(
              subtitle,
              variant: TypographyVariant.body,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isLight(context)
                    ? AppTheme(context).textColor
                    : AppTheme(context).darkModeTextColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CupertinoButton(
              color: isLight(context)
                  ? CupertinoColors.white
                  : CupertinoColors.systemGrey3,
              borderRadius: BorderRadius.circular(50),
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 8,
              ),
              child: ThemedText(
                buttonText,
                variant: TypographyVariant.button,
                style: TextStyle(
                  color: AppTheme(context).primaryColor,
                ),
              ),
              onPressed: () {
                return Navigator.of(context, rootNavigator: true)
                    .pushNamed(link.route, arguments: link.args);
              },
            ),
          ],
        ),
      ),
    );
  }
}
