import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';

class HealthCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Text(S.of(context).healthCheckTitle));
  }
}
