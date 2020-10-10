import 'package:flutter/cupertino.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class LegalLandingPage extends StatelessWidget {
  final VoidCallback onNext;

  const LegalLandingPage({@required this.onNext}) : assert(onNext != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CupertinoColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AspectRatio(
                        // Aspect ratio of image; keeps it from popping in and pushing content
                        aspectRatio: 581 / 178,
                        child: SvgPicture.asset('assets/svg/logo_banner.svg')),
                  ),
                  SizedBox(height: 8),
                  Semantics(
                    container: true,
                    child: ThemedText(
                      S.of(context).legalLandingPageTitle,
                      variant: TypographyVariant.body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(children: <Widget>[
                PageButton(
                  Constants.whoBackgroundBlueColor,
                  S.of(context).legalLandingPageButtonGetStarted,
                  onNext,
                  verticalPadding: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  borderRadius: 60,
                  titleStyle:
                      ThemedText.styleForVariant(TypographyVariant.button)
                          .merge(TextStyle(color: CupertinoColors.white)),
                ),
                SizedBox(height: 17),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                        color: CupertinoColors.systemGrey, height: 1.4),
                    children: [
                      TextSpan(text: S.of(context).legalLandingPageButtonAgree),
                      LinkTextSpan(
                        text: S
                            .of(context)
                            .LegalLandingPageTermsOfServiceLinkText,
                        style: TextStyle(decoration: TextDecoration.underline),
                        url:
                            S.of(context).legalLandingPageTermsOfServiceLinkUrl,
                        onLinkTap: (v) => launchUrl(v),
                      ),
                      TextSpan(text: S.of(context).legalLandingPageAnd),
                      LinkTextSpan(
                        text:
                            S.of(context).legalLandingPagePrivacyPolicyLinkText,
                        style: TextStyle(decoration: TextDecoration.underline),
                        url: S.of(context).legalLandingPagePrivacyPolicyLinkUrl,
                        onLinkTap: (v) => launchUrl(v),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
