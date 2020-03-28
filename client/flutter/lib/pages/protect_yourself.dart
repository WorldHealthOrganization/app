// import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:WHOFlutter/rive_animation.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

final normal = TextStyle(color: Colors.black, fontSize: 16);
final bold = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class ProtectYourself extends StatelessWidget {
  Widget get _placeholder => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.blue,
        ),
      );

  Widget get _washHandsAnimation => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.blue,
          child: RiveAnimation(
            'assets/protect.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'Hands',
          ),
        ),
      );

  Widget get _coverMouthAnimation => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.blue,
          child: RiveAnimation(
            'assets/protect.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'Cover',
          ),
        ),
      );

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
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'General Recommendations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
        ProtectYourselfCard(
            message: _washHandsMessage, child: _washHandsAnimation),
        ProtectYourselfCard(message: _avoidEyesMessage, child: _placeholder),
        ProtectYourselfCard(message: _coverMouth, child: _coverMouthAnimation),
        ProtectYourselfCard(message: _distanceMessage, child: _placeholder),
        ProtectYourselfCard(message: _maskMessage, child: _placeholder),
      ],
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
      padding: const EdgeInsets.all(10),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: message,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
