import 'package:WHOFlutter/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/page_scaffold.dart';

class HealthCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        body: Text(AppLocalizations.of(context).translate("healthCheck")));
  }
}
