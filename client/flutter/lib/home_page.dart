import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/page_button.dart';
import 'package:WHOFlutter/page_scaffold.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:WHOFlutter/pages/who_myth_busters.dart';
import 'package:WHOFlutter/widgets/scroll_down_hint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ScrollDownHint(
            controller: controller,
            child: SingleChildScrollView(
              controller: controller,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      PageButton(
                        title: S.of(context).protectYourself,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => ProtectYourself(),
                          ),
                        ),
                      ),
                      PageButton(
                        title: S.of(context).whoMythBusters,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => WhoMythBusters(),
                          ),
                        ),
                      ),
                      PageButton(
                        title: S.of(context).travelAdvice,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => TravelAdvice(),
                          ),
                        ),
                      ),
                      PageButton(
                        title: S.of(context).shareTheApp,
                        lightColor: true,
                        onPressed: () => Share.share(
                          'Check out the official COVID-19 Guide App https://www.who.int/covid-19-app',
                        ),
                      ),
                      PageButton(
                        title: S.of(context).aboutTheApp,
                        lightColor: true,
                        onPressed: () => showAboutDialog(
                          context: context,
                          applicationLegalese:
                              "The official World Health Organization COVID-19 App.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
