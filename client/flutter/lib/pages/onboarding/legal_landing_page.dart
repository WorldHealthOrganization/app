import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/rich_text_parser.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalLandingPage extends StatelessWidget {
  final PageController pageController;

  LegalLandingPage(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/WHO.jpg"),
            Text("Official WHO COVID-19 Information App", style: TextStyle(color: Color(0xff008DC9), fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            SizedBox(height: 70,),
            PageButton(
              Constants.primaryColor,
              "Get Started",
              ()=>this.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut),
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
              text: TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "By proceeding, you agree to our "
                  ),
                  LinkTextSpan(
                    text: "Terms of Service",
                    style: TextStyle(decoration: TextDecoration.underline),
                    url: "https://whocoronavirus.org/terms",
                    onLinkTap: (v)=>launch(v)
                  ),
                   TextSpan(
                    text: " and "
                  ),LinkTextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(decoration: TextDecoration.underline),
                    url: "https://whocoronavirus.org/privacy",
                    onLinkTap: (v)=>launch(v)
                  ),
                   TextSpan(
                    text: "."
                  ),
                ]

              ),
            ),
          ],
        ),
      ),
    );
  }
}
