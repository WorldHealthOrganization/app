import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class DonateSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(120, 40),
            topRight: Radius.elliptical(200, 80)),
        child: Container(
          color: Constants.accentColor,
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              ThemedText(
                "Help support the relief effort",
                variant: TypographyVariant.h2,
                style: TextStyle(
                  color: CupertinoColors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageButton(
                  CupertinoColors.white,
                  S.of(context).homePagePageSliverListDonate,
                  () => launch(S.of(context).homePagePageSliverListDonateUrl),
                  titleStyle: TextStyle(
                    color: Constants.accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  borderRadius: 50,
                  horizontalPadding: 32,
                  verticalPadding: 8,
                ),
              ),
              Container(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
