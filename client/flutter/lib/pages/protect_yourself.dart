// import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:WHOFlutter/components/rive_animation.dart';
import 'package:flutter/material.dart';

const whoBlue = Color(0xFF3D8BCC);
const normal = TextStyle(
  fontFamily: 'SFProText',
  color: Colors.black,
  fontSize: 16,
);
const bold = TextStyle(
  fontFamily: 'SFProText',
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
const header = TextStyle(
  fontFamily: 'SFProDisplayHeavy',
  color: Colors.black,
  fontSize: 24,
);

class ProtectYourself extends StatelessWidget {
  Widget get _placeholder => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: whoBlue,
        ),
      );

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

  RichText get _washHandsMessage => RichText(
        text: TextSpan(
          style: normal,
          children: <TextSpan>[
            TextSpan(
              text: 'Wash your hands',
              style: bold,
            ),
            TextSpan(
              text: ' with soap and water for at least 20 seconds',
            ),
          ],
        ),
      );

  RichText get _avoidEyesMessage => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: normal,
          children: <TextSpan>[
            TextSpan(
              text: 'Avoid touching',
              style: bold,
            ),
            TextSpan(text: ' your eyes, mouth and nose'),
          ],
        ),
      );

  RichText get _coverMouth => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: normal,
          children: <TextSpan>[
            TextSpan(
              text: 'Cover your mouth and nose',
              style: bold,
            ),
            TextSpan(
                text: ' with your bent elbow or tissue'
                    ' when you cough or sneeze'),
          ],
        ),
      );

  RichText get _distanceMessage => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: normal,
          children: <TextSpan>[
            TextSpan(text: 'Stay more than '),
            TextSpan(
              text: '1 meter (>3 feet) away from a person who is sick',
              style: bold,
            ),
          ],
        ),
      );

  RichText get _maskMessage => RichText(
        text: TextSpan(
          text: 'Only wear a mask if you or someone you'
              ' are looking after are ill with COVID-19 symptoms'
              ' (especially coughing)',
          style: normal,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListOfItems(
      [
        Padding(
          padding: const EdgeInsets.only(left: 26, top: 20),
          child: Text(
            'General Recommendations',
            style: header,
          ),
        ),
        ProtectYourselfCard(
          message: _washHandsMessage,
          child: _washHandsAnimation,
        ),
        ProtectYourselfCard(
          message: _avoidEyesMessage,
          child: _avoidTouchingAnimation,
        ),
        ProtectYourselfCard(
          message: _coverMouth,
          child: _coverMouthAnimation,
        ),
        ProtectYourselfCard(
          message: _distanceMessage,
          child: _placeholder,
        ),
        ProtectYourselfCard(
          message: _maskMessage,
          child: _protectAnimation,
        ),
      ],
      title: 'Protect Yourself',
    );
  }
}

class ProtectYourselfCard extends StatelessWidget {
  const ProtectYourselfCard({
    @required this.message,
    @required this.child,
  });
  final RichText message;
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
