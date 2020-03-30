// import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:WHOFlutter/components/rive_animation.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';

const whoBlue = Color(0xFF3D8BCC);
const normal = TextStyle(
  color: Colors.black,
  fontSize: 16,
);
const bold = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
const header = TextStyle(
  color: Colors.black,
  fontSize: 24,
);

Text _message(String input) {
  // Make sections delineated by asterisk * bold. For example:
  // String text = '*This is bold* this is not';

  var regex = RegExp(r'\*([^,*]+)\*');

  var matched = regex.allMatches(input);

  var spans = <TextSpan>[];
  int before = 0;
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
  Widget _getAnimation(String animationName) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
          child: RiveAnimation(
            'assets/animations/protect.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: animationName,
          ),
        ),
      );

  Widget get _washHandsAnimation => _getAnimation('Hands');

  Widget get _coverMouthAnimation => _getAnimation('Cover');

  Widget get _avoidTouchingAnimation => _getAnimation('Face');

  Widget get _protectAnimation => _getAnimation('Mask');

  Widget get _distanceAnimation => _getAnimation('Stay');

  @override
  Widget build(BuildContext context) {
    var localized = S.of(context);
    return ListOfItems(
      [
        Padding(
          padding: const EdgeInsets.only(left: 26, top: 20),
          child: Text(
            localized.protectYourselfHeader,
            style: header,
          ),
        ),
        ProtectYourselfCard(
          message: _message(localized.protectYourselfListOfItemsPageListItem1),
          child: _washHandsAnimation,
        ),
        ProtectYourselfCard(
          message: _message(localized.protectYourselfListOfItemsPageListItem2),
          child: _avoidTouchingAnimation,
        ),
        ProtectYourselfCard(
          message: _message(localized.protectYourselfListOfItemsPageListItem3),
          child: _coverMouthAnimation,
        ),
        ProtectYourselfCard(
          message: _message(localized.protectYourselfListOfItemsPageListItem4),
          child: _distanceAnimation,
        ),
        ProtectYourselfCard(
          message: _message(localized.protectYourselfListOfItemsPageListItem5),
          child: _protectAnimation,
        ),
      ],
      title: localized.protectYourselfTitle,
    );
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
