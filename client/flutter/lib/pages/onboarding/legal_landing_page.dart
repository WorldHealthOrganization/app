import 'package:flutter/cupertino.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class LegalLandingPage extends StatelessWidget {
  final VoidCallback onNext;

  const LegalLandingPage({@required this.onNext}) : assert(onNext != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset('assets/svg/logo_banner.svg'),
                  SizedBox(height: 20),
                  Semantics(
                    container: true,
                    child: Text(
                      S.of(context).legalLandingPageTitle,
                      style: TextStyle(
                        color: Constants.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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
                  Constants.primaryColor,
                  S.of(context).legalLandingPageButtonGetStarted,
                  onNext,
                  verticalPadding: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  borderRadius: 60,
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
                        onLinkTap: (v) => launch(v),
                      ),
                      TextSpan(text: S.of(context).legalLandingPageAnd),
                      LinkTextSpan(
                        text:
                            S.of(context).legalLandingPagePrivacyPolicyLinkText,
                        style: TextStyle(decoration: TextDecoration.underline),
                        url: S.of(context).legalLandingPagePrivacyPolicyLinkUrl,
                        onLinkTap: (v) => launch(v),
                      ),
                      TextSpan(text: "."),
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
