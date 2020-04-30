import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class HomePageAdCard extends StatelessWidget {
  final HomePageAdType adType;

  HomePageAdCard(this.adType);

  Color get cardColor {
    switch (this.adType) {
      case HomePageAdType.GettheFacts:
        return Color(0xffD5F5FD);
        break;
      default:
        return Color(0xffD5F5FD);
    }
  }

  Color get titleColor {
    switch (this.adType) {
      case HomePageAdType.GettheFacts:
        return Color(0xff1A458E);
        break;
      default:
        return Color(0xff1A458E);
    }
  }

  String message(BuildContext context) {
    switch (this.adType) {
      case HomePageAdType.GettheFacts:
        return "Spraying alcohol or chlorine all over your body <b>does not</b> kill the new coronavirus.";
        break;
      default:
        return "Spraying alcohol or chlorine all over your body <b>does not</b> kill the new coronavirus.";
    }
  }

  String buttonText(BuildContext context) {
    switch (this.adType) {
      case HomePageAdType.GettheFacts:
        return "Learn more";
        break;
      default:
        return "Learn more";
    }
  }

  Function onPressed(BuildContext context) {
    switch (this.adType) {
      case HomePageAdType.GettheFacts:
        return () {};
        break;
      default:
        return () {};
    }
  }

  String title(BuildContext context) {
    switch (this.adType) {
      case HomePageAdType.GettheFacts:
        return S.of(context).homePagePageButtonWHOMythBusters;
        break;
      default:
        return S.of(context).homePagePageButtonWHOMythBusters;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(16),
            color: this.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.title(context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: this.titleColor,
                  ),
                ),
                Html(
                  data: this.message(context),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(50),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 8,
                      ),
                      color: CupertinoColors.white,
                      child: ThemedText(
                        this.buttonText(context),
                        variant: TypographyVariant.button,
                        style: TextStyle(
                          color: Constants.primaryColor,
                        ),
                      ),
                      onPressed: this.onPressed(context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum HomePageAdType { GettheFacts }
