import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/page_scaffold.dart';

class HealthCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(body: Text(S.of(context).healthCheck));
  }
}
