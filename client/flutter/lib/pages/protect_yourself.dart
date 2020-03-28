import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:flutter/material.dart';

class ProtectYourself extends StatelessWidget {
  RichText get _washHands => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Wash your hands',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' with soap and water for at least 20 seconds'),
          ],
        ),
      );

  RichText get _avoidEyes => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Avoid touching',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' your eyes, mouth and nose'),
          ],
        ),
      );

  RichText get _coverMouth => RichText(
        text: TextSpan(
          // text: 'Wash your hands frequently',
          style: TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Cover your mouth and nose',
              style: TextStyle(fontWeight: FontWeight.bold),
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
          style: TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: 'Stay more than '),
            TextSpan(
              text: '1 meter (>3 feet) away from a person who is sick',
              style: TextStyle(fontWeight: FontWeight.bold),
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
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListOfItems(
      [
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
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
            const SizedBox(height: 10),
            message,
          ],
        ),
      ),
    );
  }
}
