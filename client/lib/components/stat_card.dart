import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class StatCard extends StatelessWidget {
  final String stat;
  final String title;

  const StatCard({
    @required this.stat,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      child: Container(
        color: CupertinoColors.white,
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: Constants.neutralTextLightColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                height: 2.13,
              ),
            ),
            Container(
              height: 8.0,
            ),
            ThemedText(
              stat,
              variant: TypographyVariant.h2,
              softWrap: true,
              style: TextStyle(
                color: Constants.primaryColor,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
