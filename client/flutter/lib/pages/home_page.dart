import 'package:WHOFlutter/api/content/dynamic_content.dart';
import 'package:WHOFlutter/change_notifiers/debug_change_notifier.dart';
import 'package:WHOFlutter/components/page_button.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/main.dart';
import 'package:WHOFlutter/pages/about_page.dart';
import 'package:WHOFlutter/pages/facts_carousel_page.dart';
import 'package:WHOFlutter/pages/latest_numbers.dart';
import 'package:WHOFlutter/pages/news_feed.dart';
import 'package:WHOFlutter/pages/protect_yourself.dart';
import 'package:WHOFlutter/pages/question_index.dart';
import 'package:WHOFlutter/pages/settings_page.dart';
import 'package:WHOFlutter/pages/travel_advice.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

const String loremExtract =
    ' Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
const String longWord = 'Supercalifragilisticexpialidocious';

class HomePage extends StatefulWidget {
  final FirebaseAnalytics analytics;

  HomePage(this.analytics);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _textScaleFactor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textScaleFactor ??= MediaQuery.textScaleFactorOf(context);
  }

  _logAnalyticsEvent(String name) async {
    await widget.analytics.logEvent(name: name);
  }

  void updateTextScaleFactor(double value) {
    setState(() {
      _textScaleFactor = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String versionString = packageInfo != null
        ? '${S.of(context).commonWorldHealthOrganizationCoronavirusAppVersion(packageInfo.version, packageInfo.buildNumber)}\n'
        : null;

    final String copyrightString = S
        .of(context)
        .commonWorldHealthOrganizationCoronavirusCopyright(DateTime.now().year);

    final divider = Container(height: 1, color: Color(0xffC9CDD6));

    final DebugChangeNotifier debugChangeNotifier =
        context.watch<DebugChangeNotifier>();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: _textScaleFactor),
      child: PageScaffold(
          title: S.of(context).homePagePageTitle,
          subtitle: S.of(context).homePagePageSubTitle,
          showBackButton: false,
          showLogoInHeader: true,
          body: [
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                const SizedBox(height: 8),
                _LabelledSlider(
                  label: 'TextScaleFactor(System based)',
                  value: _textScaleFactor,
                  onChanged: updateTextScaleFactor,
                  min: 0.5,
                  max: 1.5,
                ),
                _LabelledSlider(
                  label: 'Extra Characters',
                  value: debugChangeNotifier.extraCharacters.toDouble(),
                  onChanged: (v) => debugChangeNotifier.extraCharacters = v,
                  min: 0,
                  max: 60,
                  divisions: 39,
                ),
                _LabelledSlider(
                  label: 'First Word Characters',
                  value: debugChangeNotifier.firstWordCharacters.toDouble(),
                  onChanged: (v) => debugChangeNotifier.firstWordCharacters = v,
                  min: 0,
                  max: 30,
                  divisions: 29,
                ),
                _MenuGrid(logAnalyticsEvent: _logAnalyticsEvent),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  child: Text(
                    S.of(context).homePagePageSliverListSupport,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: -.5,
                      fontWeight: FontWeight.bold,
                      color: Constants.accent,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: PageButton(
                      Constants.accent,
                      S.of(context).homePagePageSliverListDonate,
                      () {
                        _logAnalyticsEvent('Donate');
                        launch(S.of(context).homePagePageSliverListDonateUrl);
                      },
                      borderRadius: 36,
                      verticalPadding: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    )),
                SizedBox(
                  height: 20,
                ),
                divider,
                Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.share, color: Constants.accent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              S.of(context).homePagePageSliverListShareTheApp,
                              style: TextStyle(
                                color: Constants.accent,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFC9CDD6),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      widget.analytics.logShare(
                          contentType: 'App',
                          itemId: null,
                          method: 'Website link');
                      Share.share(
                          S.of(context).commonWhoAppShareIconButtonDescription);
                    },
                  ),
                ),
                divider,
                Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.settings, color: Constants.accent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              S.of(context).homePagePageSliverListSettings,
                              style: TextStyle(
                                color: Constants.accent,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFC9CDD6),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _logAnalyticsEvent('Settings');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => SettingsPage()),
                      );
                    },
                  ),
                ),
                divider,
                Material(
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      S.of(context).homePagePageSliverListAboutTheApp,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFC9CDD6),
                    ),
                    onTap: () {
                      _logAnalyticsEvent('About');
                      return Navigator.of(context)
                          .push(MaterialPageRoute(builder: (c) => AboutPage()));
                    },
                  ),
                ),
                divider,
                Container(
                  height: 25,
                ),
                Text(
                  '${versionString ?? ''}$copyrightString',
                  style: TextStyle(color: Color(0xff26354E).withOpacity(0.75)),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 40,
                ),
              ]),
            )
          ]),
    );
  }
}

class _LabelledSlider extends StatelessWidget {
  const _LabelledSlider({
    Key key,
    @required this.min,
    @required this.max,
    @required this.value,
    @required this.onChanged,
    @required this.label,
    this.divisions,
  }) : super(key: key);
  final double min;
  final double max;
  final double value;
  final Function(double) onChanged;
  final String label;
  final int divisions;

  @override
  Widget build(BuildContext context) {
    final String valueString = value.toStringAsFixed(2);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(label),
                Text(valueString),
              ],
            ),
          ),
          SizedBox(
            height: 32,
            child: Slider.adaptive(
              value: value,
              onChanged: onChanged,
              min: min,
              max: max,
              label: valueString,
              divisions: divisions,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  const _MenuGrid({Key key, @required this.logAnalyticsEvent})
      : assert(logAnalyticsEvent != null),
        super(key: key);

  final Function(String) logAnalyticsEvent;

  final TextStyle largeTitleStyle =
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 28);

  final TextStyle mediumTitleStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  final double heightScale = 0.73;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      staggeredTiles: [
        StaggeredTile.count(1, 2 * heightScale),
        StaggeredTile.count(1, heightScale),
        StaggeredTile.count(1, heightScale),
        StaggeredTile.count(2, heightScale),
        StaggeredTile.count(1, heightScale),
        StaggeredTile.count(1, heightScale),
      ],
      children: <Widget>[
        _MenuButton(
          onTap: () => logAnalyticsEvent('ProtectYourself'),
          pageBuilder: () => ProtectYourself(),
          scaleFactor: 2,
          color: Color(0xff008DC9),
          title: S.of(context).homePagePageButtonProtectYourself,
          mainAxisAlignment: MainAxisAlignment.end,
          titleStyle: largeTitleStyle,
        ),
        _MenuButton(
          onTap: () => logAnalyticsEvent('LatestNumbers'),
          pageBuilder: () => LatestNumbers(),
          color: Color(0xff1A458E),
          title: S.of(context).homePagePageButtonLatestNumbers,
          titleStyle: mediumTitleStyle,
        ),
        _MenuButton(
          onTap: () => logAnalyticsEvent('QuestionsAnswered'),
          pageBuilder: () => QuestionIndexPage(
            dataSource: DynamicContent.yourQuestionsAnswered,
            title: S.of(context).homePagePageButtonQuestions,
          ),
          color: Color(0xff3DA7D4),
          title: S.of(context).homePagePageButtonYourQuestionsAnswered,
          titleStyle: mediumTitleStyle,
        ),
        _MenuButton(
          onTap: () => logAnalyticsEvent('GetTheFacts'),
          pageBuilder: () => FactsCarouselPage(
            dataSource: DynamicContent.getTheFacts,
            // TODO: Rename these keys in the ARB files
            title: S.of(context).homePagePageButtonWHOMythBusters,
          ),
          color: Color(0xff234689),
          title: S.of(context).homePagePageButtonWHOMythBusters,
          description:
              S.of(context).homePagePageButtonWHOMythBustersDescription,
          mainAxisAlignment: MainAxisAlignment.end,
          titleStyle: largeTitleStyle,
        ),
        _MenuButton(
          onTap: () => logAnalyticsEvent('TravelAdvice'),
          pageBuilder: () => TravelAdvice(),
          color: Color(0xff3DA7D4),
          title: S.of(context).homePagePageButtonTravelAdvice,
          titleStyle: mediumTitleStyle,
        ),
        _MenuButton(
          onTap: () => logAnalyticsEvent('News'),
          pageBuilder: () => NewsFeed(),
          color: Color(0xff008DC9),
          title: S.of(context).homePagePageButtonNewsAndPress,
          titleStyle: mediumTitleStyle,
        )
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  final double scaleFactor;
  final Color color;
  final String title;
  final String description;
  final Widget Function() pageBuilder;
  final VoidCallback onTap;
  final TextStyle titleStyle;
  final MainAxisAlignment mainAxisAlignment;

  const _MenuButton({
    Key key,
    @required this.pageBuilder,
    @required this.color,
    @required this.title,
    @required this.onTap,
    this.scaleFactor = 1,
    this.titleStyle = const TextStyle(fontWeight: FontWeight.w700),
    this.description,
    this.mainAxisAlignment = MainAxisAlignment.start,
  })  : assert(scaleFactor != null),
        assert(pageBuilder != null),
        assert(title != null),
        assert(titleStyle != null),
        assert(mainAxisAlignment != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final DebugChangeNotifier debugChangeNotifier =
        context.watch<DebugChangeNotifier>();
    final int extraCharacters = debugChangeNotifier.extraCharacters;

    final int firstWordCharacters = debugChangeNotifier.firstWordCharacters;
    final bool addSpace = firstWordCharacters > 0;
    return HomePageButton(
      backgroundColor: color,
      title: longWord.substring(0, firstWordCharacters) +
          '${addSpace ? ' ' : ''}' +
          title +
          loremExtract.substring(0, extraCharacters),
      onPressed: onTap,
      titleStyle: titleStyle,
      description: description ?? '',
      mainAxisAlignment: mainAxisAlignment,
      borderRadius: 16,
    );
  }
}

/// Copy of PageButton with AutoSizeText
class HomePageButton extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String description;
  final double borderRadius;
  final Function onPressed;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle titleStyle;
  final Color descriptionColor;

  final double verticalPadding;
  final double horizontalPadding;

  const HomePageButton({
    this.backgroundColor,
    this.title,
    this.onPressed,
    this.description = "",
    this.borderRadius = 16,
    this.verticalPadding = 15.0,
    this.horizontalPadding = 8.0,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.titleStyle,
    this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    final AutoSizeGroup autoSizeGroup =
        context.watch<DebugChangeNotifier>().homeAutoSizeGroup;
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            Flexible(
              child: AutoSizeText(
                title,
                maxLines: 2,
                textAlign: TextAlign.left,
                group: autoSizeGroup,
                style: titleStyle?.copyWith(
                      letterSpacing: Constants.buttonTextSpacing,
                    ) ??
                    TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: Constants.buttonTextSpacing,
                      fontSize: 18,
                    ),
              ),
            ),
            // Makes sure text is centered properly when no description is provided
            SizedBox(height: description.isNotEmpty ? 4 : 0),
            if (description.isNotEmpty)
              Flexible(
                child: AutoSizeText(
                  description,
                  textAlign: TextAlign.left,
                  // textScaleFactor: (0.9 + 0.5 * contentScale(context)) *
                  // MediaQuery.textScaleFactorOf(context),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: descriptionColor ?? Color(0xFFC9CDD6),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
