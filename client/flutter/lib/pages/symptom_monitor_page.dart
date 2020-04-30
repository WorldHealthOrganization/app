import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:who_app/components/forms.dart';
import 'package:who_app/components/page_button.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

class SymptomsResultPage extends StatelessWidget {
  final int risk;

  const SymptomsResultPage({Key key, @required this.risk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      disableBackButton: true,
      showHeader: false,
      title: "Check-Up",
      body: <Widget>[_buildBody(context)],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        SafeArea(child: headingWidget(context)),
        bodyWidget(context),
        submitWidget(context),
      ]));

  Widget headingWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 64),
      child: Column(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.solidCheckCircle,
            color:
                risk < 2 ? CupertinoColors.activeGreen : Constants.primaryColor,
            size: 48,
          ),
          SizedBox(
            height: 32,
          ),
          ThemedText(
            risk < 2 ? "Thanks for recording!" : "Your symptoms were recorded",
            variant: TypographyVariant.h2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(),
      child: Column(
        children: <Widget>[],
      ),
    );
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
        "My Dashboard",
        () {
          return Navigator.of(context, rootNavigator: true).pop();
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

class SickPage extends StatelessWidget {
  const SickPage();

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "Check-Up",
      body: <Widget>[_buildBody()],
    );
  }

  Widget _buildBody() => SliverList(
          delegate: SliverChildListDelegate([
        questionWidget(),
        ...optionWidgets(),
        submitWidget(),
      ]));

  Widget questionWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 12,
      ),
      child: Text(
        "Which of the following best describes how you’re feeling?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  List<Widget> optionWidgets() {
    List<Map<String, String>> items = <Map<String, String>>[
      {"title": "Healthy", "icon": "🙂"},
      {"title": "Sick, unwell, tired", "icon": "🤒"},
    ];
    return items.asMap().entries.map((entry) {
      return ToggleOption(
        title: entry.value["title"],
        icon: entry.value["icon"],
        color: CupertinoColors.white,
      );
    }).toList();
  }

  Widget submitWidget() {
    return _NextButton(
      onPressed: () {},
    );
  }
}

class _NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _NextButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 24,
        right: 24,
        bottom: 48,
      ),
      child: PageButton(
        Constants.primaryColor,
        "Next",
        onPressed,
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

class SymptomsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SymptomsListPageState();
}

class _SymptomsListPageState extends State<SymptomsListPage> {
  bool nextPage = false;
  List<bool> answers;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "Check-Up",
      body: <Widget>[_buildBody(context)],
    );
  }

  Widget _buildBody(BuildContext context) => SliverList(
          delegate: SliverChildListDelegate([
        questionWidget(),
        ...optionWidgets(),
        submitWidget(context),
      ]));

  Widget questionWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 12,
      ),
      child: Text(
        "Which of the following symptoms are you experiencing (select all that apply)?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  List<Widget> optionWidgets() {
    List<Map<String, String>> items = <Map<String, String>>[
      {"title": "Fever", "icon": "🤒"},
      {"title": "Dry cough", "icon": "😣"},
      {"title": "Shortness of breath", "icon": "😦"},
      {"title": "Loss of sense of smell", "icon": "👃"},
      {"title": "Extreme tiredness/fatigue", "icon": "😴"},
      {"title": "Chills or sweating", "icon": "😓"},
      {"title": "Headache", "icon": "🤕"},
      {"title": "Sore throat", "icon": "😶"},
      {"title": "Body aches", "icon": "😣"},
      {"title": "Vomiting/diarrhea", "icon": "🤢"},
      {"title": "None of the above", "icon": "🙂", "noneOfTheAbove": ""},
    ];
    final sel = List<bool>.filled(items.length, false);
    return <Widget>[
      PickOneOrMoreOptionGroup(
        items: items,
        onPressed: (idx, s) {
          setState(() {
            answers = List<bool>.unmodifiable(s);
            nextPage = answers.contains(true);
          });
        },
        isSelected: sel,
      )
    ];
  }

  Widget submitWidget(BuildContext context) {
    return _NextButton(
      onPressed: nextPage
          ? () {
              // Risk engine
              int risk = answers[10] ? 0 : 1;
              if (answers[0] && (answers[1] || answers[2] || answers[3])) {
                risk = 2;
              }
              return Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/symptom-results', arguments: risk);
            }
          : null,
    );
  }
}
