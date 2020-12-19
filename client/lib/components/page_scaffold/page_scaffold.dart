import 'package:who_app/api/alerts.dart';
import 'package:who_app/components/page_scaffold/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final Widget headerWidget;
  final String heroTag;
  final List<Widget> body;
  final List<Widget> beforeHeader;
  final Color color;
  final Color appBarColor;
  final Color headingBorderColor;
  final bool showBackButton;
  final TextStyle headerTitleStyle;
  final Widget header;
  final Widget trailing;
  final Widget appBarBottom;

  final bool showHeader;

  final EdgeInsets padding;

  PageScaffold({
    @required this.body,
    this.title,
    this.headerWidget,
    this.heroTag,
    this.header,
    this.showHeader = true,
    this.padding = EdgeInsets.zero,
    this.color = Constants.greyBackgroundColor,
    this.appBarColor,
    this.headingBorderColor = const Color(0xffC9CDD6),
    this.beforeHeader = const <Widget>[],
    this.showBackButton = true,
    this.headerTitleStyle,
    this.trailing,
    this.appBarBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Padding(
        padding: padding,
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              // Disables scrolling when there's insufficient content to scroll
              primary: false,
              slivers: [
                ...beforeHeader,
                if (showHeader)
                  (header ??
                      PageHeader(
                        title: title,
                        headerWidget: headerWidget,
                        heroTag: heroTag ?? title,
                        borderColor: headingBorderColor,
                        showBackButton: showBackButton,
                        titleStyle: headerTitleStyle,
                        appBarColor: appBarColor ?? color,
                        appBarBottom: appBarBottom,
                        trailing: trailing,
                      )),
                ...body,
                SliverToBoxAdapter(
                  child: SizedBox(height: 170),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlertsWrapper extends StatefulWidget {
  const AlertsWrapper({
    Key key,
    @required this.alerts,
    @required this.child,
  }) : super(key: key);

  final List<Alert> alerts;
  final Widget child;

  @override
  _AlertsWrapperState createState() => _AlertsWrapperState(alerts);
}

abstract class AlertController {
  void removeAlert(Alert a);
  void addAlert(Alert a);
}

class _AlertsWrapperState extends State<AlertsWrapper>
    implements AlertController {
  _AlertsWrapperState(List<Alert> alerts) : _alerts = List.from(alerts);

  final List<Alert> _alerts;

  @override
  void removeAlert(Alert a) {
    if (mounted) {
      setState(() {
        _alerts.remove(a);
      });
    }
  }

  @override
  void addAlert(Alert a) {
    if (mounted) {
      setState(() {
        _alerts.add(a);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ..._alerts.asMap().entries.map(
            (entry) {
              var index = entry.key;
              var alert = entry.value;
              return _Alert(
                alert: alert,
                controller: this,
                topPadding: index == 0,
              );
            },
          ),
          Expanded(
              child: MediaQuery.removePadding(
                  removeTop: _alerts.isNotEmpty,
                  context: context,
                  child: widget.child)),
        ],
      ),
    );
  }
}

class _Alert extends StatelessWidget {
  const _Alert({
    Key key,
    this.topPadding,
    @required this.alert,
    @required this.controller,
  }) : super(key: key);

  final bool topPadding;
  final Alert alert;
  final AlertController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: alert.color,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: SafeArea(
        bottom: false,
        maintainBottomViewPadding: false,
        top: topPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (alert.title != null)
                      ThemedText(
                        alert.title,
                        variant: TypographyVariant.headerSmall,
                        style: TextStyle(color: Colors.white),
                      ),
                    if (alert.body != null)
                      ThemedText(
                        alert.body,
                        variant: TypographyVariant.body,
                        style: TextStyle(color: Colors.white, height: 1.2),
                      ),
                  ],
                )),
                if (alert.dismissable)
                  IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      onPressed: () {
                        controller.removeAlert(alert);
                      }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
