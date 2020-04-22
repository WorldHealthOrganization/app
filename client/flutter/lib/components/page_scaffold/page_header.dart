import './back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Used to get latest AppBar features while remaining on Flutter's stable branch
import 'package:who_app/components/updated_app_bar.dart' as uab;

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  final EdgeInsets padding;
  final bool showBackButton;
  final bool showLogo;

  /// True if [PageHeader] wouldn't be announced via the screen reader if it wasn't
  /// wrapped in a [Semantics] widget. E.g. when opening a page with
  /// [SwipeableOpenContainer]
  final bool announceRouteManually;

  PageHeader({
    @required this.title,
    this.subtitle = "",
    this.padding = EdgeInsets.zero,
    this.showBackButton = true,
    this.showLogo = false,
    this.announceRouteManually = false,
  });

  @override
  Widget build(BuildContext context) {
    return uab.SliverAppBar(
      leading: Container(),
      expandedHeight: 120,
      backgroundColor: Colors.white,
      excludeHeaderSemantics: true,
      flexibleSpace: FlexibleSpaceBar(background: _buildHeader(context)),
    );
  }

  Widget _buildHeader(BuildContext context) {
    Widget child = BackArrow();

    if (announceRouteManually) {
      child = Semantics(focused: true, label: title, child: child);
    }

    List<Widget> headerItems = [
      if (showBackButton)
        Transform.translate(
          offset: Offset(-12, 0),
          child: child,
        ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Todo: Decide what to do when title text overflow
            buildTitle(this.title),
            SizedBox(height: 4),
            AutoSizeText(this.subtitle,
                maxLines: 1,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    color: Color(0xff3C4245),
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      if (this.showLogo)
        Image.asset(
          'assets/images/mark.png',
          width: 70,
          excludeFromSemantics: true,
        )
    ];
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: headerItems),
            ),
            Positioned(
                bottom: 0,
                height: 1,
                child: Container(
                  height: 1,
                  color: Color(0xffC9CDD6),
                  width: MediaQuery.of(context).size.width,
                ))
          ],
        ),
      ),
    );
  }

  static const textColor = Color(0xff1A458E);

  static Widget buildTitle(String title) {
    return Semantics(
      header: true,
      namesRoute: true,
      child: AutoSizeText(title,
          maxLines: 1,
          minFontSize: 8,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              letterSpacing: -0.5)),
    );
  }
}
