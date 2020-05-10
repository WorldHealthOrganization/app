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
          color: Constants.illustrationBlue1Color,
          padding: EdgeInsets.fromLTRB(16.0, 36.0, 12.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ThemedText(
                this.title,
                variant: TypographyVariant.h3,
                style: TextStyle(
                  color: Constants.primaryDarkColor,
                ),
              ),
              Container(
                height: 6.0,
              ),
              ThemedText(
                this.subtitle,
                variant: TypographyVariant.body,
                style: TextStyle(
                  color: Constants.neutralTextDarkColor,
                ),
              ),
              Container(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CupertinoButton(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                    child: ThemedText(
                      this.buttonText,
                      variant: TypographyVariant.button,
                      style: TextStyle(
                        color: Constants.primaryColor,
                      ),
                    ),
                    onPressed: () {
                      return this.link.open(context);
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
