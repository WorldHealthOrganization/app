import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/pages/onboarding/onboarding_page.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalLandingPage extends StatelessWidget {
  final OnboardingPage onboardingPage;

  LegalLandingPage(this.onboardingPage);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset('assets/images/mark.png',
                      width: contentScaleFrom(context, 90, 120)),
                  SizedBox(width: contentScaleFrom(context, 5, 10)),
                  Flexible(
                    child: Text(S.of(context).commonWorldHealthOrganization,
                        textScaleFactor: contentScaleFrom(context, 1.7, 2.7),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff008DC9))),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).legalLandingPageTitle,
              style: TextStyle(
                  color: Color(0xff008DC9),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            PageButton(
              Constants.primaryColor,
              S.of(context).legalLandingPageButtonGetStarted,
              () => this.onboardingPage.pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              verticalPadding: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              borderRadius: 60,
            ),
            SizedBox(
              height: 17,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: S.of(context).legalLandingPageButtonAgree),
                LinkTextSpan(
                    text: S.of(context).LegalLandingPageTermsOfServiceLinkText,
                    style: TextStyle(decoration: TextDecoration.underline),
                    url: S.of(context).legalLandingPageTermsOfServiceLinkUrl,
                    onLinkTap: (v) => launch(v)),
                TextSpan(text: S.of(context).legalLandingPageAnd),
                LinkTextSpan(
                    text: S.of(context).legalLandingPagePrivacyPolicyLinkText,
                    style: TextStyle(decoration: TextDecoration.underline),
                    url: S.of(context).legalLandingPagePrivacyPolicyLinkUrl,
                    onLinkTap: (v) => launch(v)),
                TextSpan(text: "."),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
