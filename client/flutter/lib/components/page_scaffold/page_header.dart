import './back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  final EdgeInsets padding;
  final bool showBackButton;
  final bool showLogo;

  PageHeader({
    @required this.title,
    this.subtitle = "COVID-19",
    this.padding = EdgeInsets.zero,
    this.showBackButton = true,
    this.showLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      expandedHeight: 120,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(background: _buildHeader(context)),
    );
  }

  Widget _buildHeader(BuildContext context) {
    List<Widget> headerItems = [
      if (this.showBackButton)
        Transform.translate(offset: Offset(-12, 0), child: BackArrow()),
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Todo: Decide what to do when title text overflow
          AutoSizeText(this.title,
              maxLines: 1,
              minFontSize: 8,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                  color: Color(0xff1A458E),
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  letterSpacing: -0.5)),
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
      ),),
      if (this.showLogo) Image.asset('assets/images/mark.png', width: 70)
    ];
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: headerItems),
            ),
            Positioned(
              bottom: 0,
              height: 1,
              child:  Container(
                  height: 1,
                  color: Color(0xffC9CDD6),
                  width: MediaQuery.of(context).size.width,
                ) 
              
            )
          ],
        ),
      ),
    );
  }
}
