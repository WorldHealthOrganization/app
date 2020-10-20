import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:who_app/api/linking.dart';
import 'package:who_app/components/button.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class HomePageDonate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 72.0,
          ),
          child: ThemedText(
            // TODO: localize
            'Help support the relief effort',
            variant: TypographyVariant.h2,
            style: TextStyle(
              color: Constants.accentTealColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          child: Button(
            borderRadius: BorderRadius.circular(50.0),
            backgroundColor: Constants.accentTealColor,
            padding: EdgeInsets.symmetric(horizontal: 88.0, vertical: 12.0),
            child: ThemedText(
              // TODO: localize
              'Donate Now',
              variant: TypographyVariant.button,
              style: TextStyle(
                color: CupertinoColors.white,
              ),
            ),
            onPressed: () {
              FirebaseAnalytics().logEvent(name: 'Donate');
              launchUrl(S.of(context).homePagePageSliverListDonateUrl);
            },
          ),
        ),
        _DonateFooterGraphic(),
      ],
    );
  }
}

class _DonateFooterGraphic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _DonateBackground(),
        Container(
          padding: EdgeInsets.only(bottom: 16.0),
          child: SvgPicture.asset('assets/svg/undraw-home-donate.svg'),
        ),
      ],
    );
  }
}

class _DonateBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(
        color: Constants.primaryDarkColor,
        height: 136.0,
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 46.0);
    path.arcToPoint(Offset(size.width, 79.0),
        radius: Radius.elliptical(size.width, 200.0));
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> path) {
    return false;
  }
}
