import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/components/rive_animation.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:WHOFlutter/generated/l10n.dart';

const whoBlue = Color(0xFF3D8BCC);

const header =
    TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800);

Text _message(String input) {
  final TextStyle normal = TextStyle(
    color: Constants.textColor,
    fontSize: 16,
    height: 1.4,
  );
  final TextStyle bold = TextStyle(
    color: Constants.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  // Make sections delineated by asterisk * bold. For example:
  // String text = '*This is bold* this is not';

  var regex = RegExp(r'\*([^,*]+)\*');

  var matched = regex.allMatches(input);

  var spans = <TextSpan>[];
  var before = 0;
  for (var match in matched) {
    var value = match.group(1);
    if (before < match.start) {
      spans.add(
        TextSpan(
          text: input.substring(before, match.start),
        ),
      );
    }

    spans.add(
      TextSpan(text: value, style: bold),
    );
    before = match.end;
  }

  spans.add(
    TextSpan(
      text: input.substring(before),
    ),
  );
  return Text.rich(
    TextSpan(style: normal, children: spans),
  );
}

class ProtectYourself extends StatelessWidget {
  Widget _getImage(String svgAssetName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: SvgPicture.asset(svgAssetName),
        ),
      );

  // Widget get _washHandsImage => _getImage('assets/svg/wash_hands.svg');

  Widget get _elbowImage => _getImage('assets/svg/elbow.svg');

  Widget get _avoidTouchImage => _getImage('assets/svg/avoid_touch.svg');

  Widget get _maskImage => _getImage('assets/svg/mask.svg');

  Widget get _distanceImage => _getImage('assets/svg/social_distance.svg');

  Widget _getAnimation(String animationName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: RiveAnimation(
            'assets/animations/$animationName.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'Untitled',
          ),
        ),
      );

  // Widget get _washHandsAnimation => _getAnimation('Hands');

  // Widget get _coverMouthAnimation => _getAnimation('Cover');

  // Widget get _avoidTouchAnimation => _getAnimation('Face');

  // Widget get _protectAnimation => _getAnimation('Mask');

  // Widget get _distanceAnimation => _getAnimation('Stay');

  @override
  Widget build(BuildContext context) {
    final localized = S.of(context);

    return PageScaffold(
        title: S.of(context).protectYourselfTitle,
        showShareBottomBar: false,
        body: [
          SliverList(
              delegate: SliverChildListDelegate([
            
            ProtectYourselfCard(
              message:
                  _message(localized.protectYourselfListOfItemsPageListItem1),
              child: _getAnimation('wash_hands'),
            ),
            ProtectYourselfCard(
              message:
                  _message(localized.protectYourselfListOfItemsPageListItem2),
              child: _avoidTouchImage,
            ),
            ProtectYourselfCard(
              message:
                  _message(localized.protectYourselfListOfItemsPageListItem3),
              child: _elbowImage,
            ),
            ProtectYourselfCard(
              message:
                  _message(localized.protectYourselfListOfItemsPageListItem4),
              child: _distanceImage,
            ),
            ProtectYourselfCard(
              message:
                  _message(localized.protectYourselfListOfItemsPageListItem5),
              child: _maskImage,
            ),
          ]))
        ]);
  }
}

class ProtectYourselfCard extends StatelessWidget {
  const ProtectYourselfCard({
    @required this.message,
    @required this.child,
  });
  final Text message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: child,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: message,
            ),
          ],
        ),
      ),
    );
  }
}
