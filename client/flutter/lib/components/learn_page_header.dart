import 'package:flutter/cupertino.dart';
import 'package:who_app/constants.dart';

class LearnPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      padding: EdgeInsets.all(20),
      color: Color(0xffD5F5FD),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Text(
              "Get the Facts",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "Busting myths about COVID-19",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CupertinoButton(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(50),
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 8,
              ),
              child: Text(
                "View",
                style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
