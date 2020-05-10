import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:who_app/api/content/schema/question_content.dart';
import 'package:who_app/components/dialogs.dart';
import 'package:who_app/components/loading_indicator.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;
import 'package:who_app/pages/main_pages/routes.dart';

/// A Data driven series of questions and answers using HTML fragments.
class QuestionIndexPage extends StatefulWidget {
  final String title;
  final QuestionIndexDataSource dataSource;

  const QuestionIndexPage(
      {Key key, @required this.title, @required this.dataSource})
      : super(key: key);

  @override
  _QuestionIndexPageState createState() => _QuestionIndexPageState();
}

class _QuestionIndexPageState extends State<QuestionIndexPage> {
  QuestionContent _questionContent;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Note: this depends on the build context for the locale and hence is not
    // Note: available at the usual initState() time.
    await _loadQuestionData();
  }

  Future _loadQuestionData() async {
    if (_questionContent != null) {
      return;
    }
    Locale locale = Localizations.localeOf(context);
    try {
      _questionContent = await widget.dataSource(locale);
      await Dialogs.showUpgradeDialogIfNeededFor(context, _questionContent);
    } catch (err) {
      print("Error loading question data: $err");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildPage());
  }

  Widget _buildPage() {
    List items = (_questionContent?.items ?? []).asMap().entries.map((entry) {
      return QuestionTile(
        questionItem: entry.value,
        index: entry.key,
      );
    }).toList();

    return PageScaffold(
      heroTag: HeroTags.learn,
      body: [
        items.isNotEmpty
            ? SliverList(delegate: SliverChildListDelegate(items))
            : LoadingIndicator(),
      ],
      title: widget.title,
    );
  }
}

class QuestionTile extends StatefulWidget {
  const QuestionTile({
    @required this.questionItem,
    @required this.index,
  });

  final QuestionItem questionItem;

  final int index;

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile>
    with TickerProviderStateMixin {
  AnimationController rotationController;

  Color titleColor;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
        lowerBound: 0,
        upperBound: pi / 4);

    titleColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: <Widget>[
        Divider(
          height: 1,
          thickness: 1,
        ),
        Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
            onExpansionChanged: (expanded) {
              if (expanded) {
                FirebaseAnalytics().logEvent(
                    name: 'QuestionExpanded',
                    parameters: {'index': widget.index});
                rotationController.forward();
              } else {
                rotationController.reverse();
              }
            },
            key: PageStorageKey<String>(widget.questionItem.title),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedBuilder(
                  animation: rotationController,
                  child:
                      Icon(Icons.add_circle_outline, color: Color(0xff3C4245)),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationController.value,
                      child: child,
                    );
                  },
                ),
              ],
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Html(
                data: widget.questionItem.title,
                defaultTextStyle: _titleStyle.copyWith(
                  fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                ),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: html(widget.questionItem.body),
              )
            ],
          ),
        ),
      ]),
    );
  }

  // flutter_html supports a subset of html: https://pub.dev/packages/flutter_html
  Widget html(String html) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Html(
      data: html,
      defaultTextStyle: TextStyle(fontSize: 16 * textScaleFactor),
      linkStyle: const TextStyle(
        color: Colors.deepPurple,
      ),
      onLinkTap: (url) {
        launch(url, forceSafariVC: false);
      },
      onImageTap: (src) {},
      // This is our css :)
      customEdgeInsets: (dom.Node node) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return EdgeInsets.only(bottom: 8);
              break;
            default:
              return EdgeInsets.zero;
          }
        } else {
          return EdgeInsets.zero;
        }
      },
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "h2":
              return baseStyle.merge(TextStyle(
                  fontSize: 20,
                  color: Color(0xff3C4245),
                  fontWeight: FontWeight.w500));
            case "b":
              return baseStyle.merge(TextStyle(fontWeight: FontWeight.bold));
          }
        }
        return baseStyle.merge(_bodyStyle);
      },
    );
  }

  final _bodyStyle = TextStyle(
      color: Constants.textColor, fontWeight: FontWeight.w400, height: 1.5);

  final _titleStyle = TextStyle(
      color: Color(0xff3C4245),
      fontWeight: FontWeight.w600,
      height: 1.3); //TODO: ON OPEN MAKE TEXT DARKER
}
