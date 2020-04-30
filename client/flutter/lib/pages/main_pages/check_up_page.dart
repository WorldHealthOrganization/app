import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';

class CheckUpPage extends StatefulWidget {
  @override
  _CheckUpPageState createState() => _CheckUpPageState();
}

class _CheckUpPageState extends State<CheckUpPage> {
  bool value = false;

  _CheckUpPageState();

  @override
  Widget build(BuildContext context) {
    return _NoEntries();
  }
}

class _NoEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      disableBackButton: true,
      headingBorderColor: Color(0x0),
      title: "Check-Up",
      header: SliverSafeArea(
          sliver: SliverToBoxAdapter(
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 36, bottom: 12),
                  // TODO: localize
                  child: PageHeader.buildTitle("Check-Up",
                      textStyle: TextStyle(fontSize: 48))))),
      body: <Widget>[_buildBody(context)],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        //questionWidget(),
        ...optionWidgets(),
        submitWidget(context),
      ]));

  Widget questionWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 24,
        right: 24,
        bottom: 20,
      ),
      child: Text(
        "Which of the following symptoms are you experiencing (select all that apply):",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  List<Widget> optionWidgets() {
    return <Widget>[
      _ListItem(
          title:
              "You’ll answer a few questions about how you're feeling and any symptoms you may have.",
          icon: FontAwesomeIcons.fileMedical),
      _ListItem(
          title:
              "Your answers will not be shared with the WHO without your permission. ",
          icon: FontAwesomeIcons.lock),
      _ListItem(
          title:
              "By using this tool, you agree to its terms and that the WHO will not be liable for any harm relating to your use.",
          subtitle:
              "Recommendations provided by this tool do not constitute medical advice and should not be used to diagnose or treat medical conditions.",
          icon: FontAwesomeIcons.solidCheckCircle),
    ];
  }

  Widget submitWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 24,
        right: 24,
        bottom: 48,
      ),
      child: PageButton(
        Constants.primaryColor,
        "Get Started",
        () {
          return Navigator.of(context, rootNavigator: true)
              .pushNamed('/track-symptoms');
        },
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalPadding: 12,
        borderRadius: 500,
        titleStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  _ListItem({@required this.title, @required this.icon, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 60,
        bottom: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Constants.primaryColor,
            size: 24,
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text(
                  this.title,
                  style: TextStyle(
                      fontSize: 16,
                      height: 1.37,
                      color: Constants.bodyTextColor),
                ),
                if (this.subtitle != null)
                  SizedBox(
                    height: 8,
                  ),
                if (this.subtitle != null)
                  Text(this.subtitle,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.43,
                          color: Constants.bodyTextColor.withOpacity(0.76))),
              ])),
        ],
      ),
    );
  }
}
