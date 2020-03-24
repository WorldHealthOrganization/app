import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../page_button.dart';
import '../page_scaffold.dart';
import './protect_yourself.dart';
import './info_for_parents.dart';

class FeelingDistressedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Spacer(flex: 1),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        PageButton(
          title: S.of(context).infoForEveryone,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ProtectYourself())),
        ),
        PageButton(
            title: S.of(context).infoForParents,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => InfoForParents()))),
        Spacer(flex: 4)
      ],
    ));
  }
}
