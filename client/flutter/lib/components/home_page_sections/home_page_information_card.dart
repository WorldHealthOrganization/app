import 'package:flutter/cupertino.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class HomePageInformationCard extends StatelessWidget {
  final String buttonText;
  final RouteLink link;
  final String subtitle;
  final String title;

  const HomePageInformationCard({
    @required this.buttonText,
    @required this.link,
    @required this.subtitle,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: isLight(context)
              ? AppTheme(context).illustrationBlue1Color
              : CupertinoColors.darkBackgroundGray,
          padding: EdgeInsets.fromLTRB(16.0, 36.0, 12.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ThemedText(
                this.title,
                variant: TypographyVariant.h3,
                style: TextStyle(
                  color: AppTheme(context).primaryDarkColor,
                ),
              ),
              Container(
                height: 6.0,
              ),
              ThemedText(
                this.subtitle,
                variant: TypographyVariant.body,
                style: TextStyle(color: AppTheme(context).neutralTextDarkColor),
              ),
              Container(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CupertinoButton(
                    color: isLight(context)
                        ? CupertinoColors.white
                        : CupertinoColors.systemGrey4,
                    borderRadius: BorderRadius.circular(50.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                    child: ThemedText(
                      this.buttonText,
                      variant: TypographyVariant.button,
                      style: TextStyle(
                        color: AppTheme(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      return Navigator.of(context, rootNavigator: true)
                          .pushNamed(this.link.route, arguments: link.args);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
