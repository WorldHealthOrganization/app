import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:flutter/material.dart';

final normal = TextStyle(color: Colors.black, fontSize: 16);
final bold = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class ProtectYourself extends StatelessWidget {
  RichText get _washHands => RichText(
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

  RichText get _avoidEyes => RichText(
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

  RichText get _distance => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: normal,
          children: <TextSpan>[
            TextSpan(text: 'Stay more than '),
            TextSpan(
              text: '1 meter (>3 feet) away from a person who is sick',
              style: bold,
            ),
            TextSpan(
                text: ' with your bent elbow or tissue'
                    ' when you cough or sneeze'),
          ],
        ),
      );

  RichText get _mask => RichText(
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
        ProtectYourselfCard(message: _washHands),
        ProtectYourselfCard(message: _avoidEyes),
        ProtectYourselfCard(message: _coverMouth),
        ProtectYourselfCard(message: _distance),
        ProtectYourselfCard(message: _mask),
      ],
    );
  }
}

class ProtectYourselfCard extends StatelessWidget {
  const ProtectYourselfCard({
    this.message,
  });
  final RichText message;

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Placeholder(),
              ),
              const SizedBox(height: 20),
              message,
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
