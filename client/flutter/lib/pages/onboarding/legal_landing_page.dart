import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalLandingPage extends StatelessWidget {
  final VoidCallback onNext;

  const LegalLandingPage({@required this.onNext}) : assert(onNext != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/WHO.jpg"),
                  SizedBox(height: 20),
                  Semantics(
                    container: true,
                    child: Text(
                      S.of(context).legalLandingPageTitle,
                      style: TextStyle(
                        color: Color(0xff008DC9),
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
                  verticalPadding: 24,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  borderRadius: 60,
                ),
                SizedBox(height: 17),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.grey[600], height: 1.4),
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
