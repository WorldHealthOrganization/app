import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';

class HomePageDonate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        // height: 363.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: _DonateBackground(),
            ),
            IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 72.0, vertical: 20.0),
                      child: ThemedText(
                        'Help support the relief effort',
                        variant: TypographyVariant.h2,
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CupertinoButton(
                      borderRadius: BorderRadius.circular(50.0),
                      color: CupertinoColors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                      child: ThemedText(
                        'Donate now',
                        variant: TypographyVariant.button,
                        style: TextStyle(
                          color: Constants.accentColor,
                        ),
                      ),
                      onPressed: () {
                        launch(S.of(context).homePagePageSliverListDonateUrl);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DonateBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BackgroundClipper(),
      child: Container(
        color: Constants.accentColor,
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 46.0);
    path.arcToPoint(Offset(size.width, 72.0),
        radius: Radius.elliptical(size.width, 240.0));
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> path) {
    return true;
  }
}
