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
  /// TODO: fetch below value from shared_pref
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
                  /// (1) TODO: updating the stored user preferences
                  /// (2) TODO: turning Google Analytics on/off
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SelectableText(
                S.of(context).homePagePageSliverListSettingsHeader1,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 0 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("English", style: TextStyle(color: indexSelected == 0 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 0 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 0,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('en', 'US'));
                    indexSelected = value ? 0 : -1;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 1 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("Español", style: TextStyle(color: indexSelected == 1 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 1 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 1,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('es', 'ES'));
                    indexSelected = value ? 1 : -1;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 2 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("British English", style: TextStyle(color: indexSelected == 2 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 2 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 2,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('en', 'GB'));
                    indexSelected = value ? 2 : -1;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 3 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("Arabic", style: TextStyle(color: indexSelected == 3 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 3 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 3,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('ar', 'UE'));
                    indexSelected = value ? 3 : -1;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 4 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("French", style: TextStyle(color: indexSelected == 4 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 4 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 4,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('fr', 'FR'));
                    indexSelected = value ? 4 : -1;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 5 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("Russian", style: TextStyle(color: indexSelected == 5 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 5 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 5,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('ru', 'RU'));
                    indexSelected = value ? 5 : -1;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChoiceChip(
                selectedColor: indexSelected == 6 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("Chinese", style: TextStyle(color: indexSelected == 6 ? Colors.white : Colors.black),),
                  trailing: indexSelected == 6 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: indexSelected == 6,
                onSelected: (value){
                  setState(() {
                    S.delegate.load(Locale('zh', 'CN'));
                    indexSelected = value ? 6 : -1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    ], title: S.of(context).homePagePageSliverListSettings,);
  }
}

