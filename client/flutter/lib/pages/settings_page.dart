import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:WHOFlutter/components/list_of_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue;
  int indexSelected = 0;

  @override
  void initState() {
    super.initState();
    if (_switchValue == null) {
      _initSwitch();
    }
  }

  _initSwitch() async {
    _switchValue = await UserPreferences().getAnalyticsEnabled();
    setState(() {});
  }

  _toggleAnalytics(bool value) async {
    await UserPreferences().setAnalyticsEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    return ListOfItems(
      [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: SelectableText(
                  S.of(context).homePagePageSliverListSettingsHeader1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: CupertinoSwitch(
                  activeColor: Constants.primaryColor,
                  value: _switchValue ?? false,
                  onChanged: (newValue) async {
                    await _toggleAnalytics(newValue);
                    setState(() {
                      _switchValue = newValue;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: SelectableText(
                  S.of(context).homePagePageSliverListSettingsDataCollection,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SelectableText(
                  S.of(context).homePagePageSliverListSettingsHeader2,
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
                    title: Text("French", style: TextStyle(color: indexSelected == 1 ? Colors.white : Colors.black),),
                    trailing: indexSelected == 1 ? Icon(Icons.check, color: Colors.white,) : null,
                  ),
                  selected: indexSelected == 1,
                  onSelected: (value){
                    setState(() {
                      S.delegate.load(Locale('fr', 'FR'));
                      indexSelected = value ? 1 : -1;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      title: S.of(context).homePagePageSliverListSettings,
    );
  }

}
