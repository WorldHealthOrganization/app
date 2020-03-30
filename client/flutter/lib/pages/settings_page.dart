import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// TODO: Get all the strings from generated file

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue = true;
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ListOfItems([
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: SelectableText(
                S.of(context).homePagePageSliverListSettingsHeader1,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700,),
              ),
              trailing: CupertinoSwitch(
                activeColor: Constants.primaryColor,
                value: _switchValue,
                onChanged: (value){
                  /// TODO: Take actions here!
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: SelectableText(
                S.of(context).homePagePageSliverListSettingsDataCollection,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ],
        ),
      ),
    ], title: S.of(context).homePagePageSliverListSettings,);
  }
}

