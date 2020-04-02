import 'package:WHOFlutter/api/user_preferences.dart';
import 'package:WHOFlutter/components/page_scaffold/page_scaffold.dart';
import 'package:WHOFlutter/constants.dart';
import 'package:WHOFlutter/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue;
  int _indexSelected;

  @override
  void initState() {
    super.initState();
    if (_switchValue == null) _initSwitch();
    if(_indexSelected == null) _initAppLanguage();
  }

  _initSwitch() async {
    _switchValue = await UserPreferences().getAnalyticsEnabled();
    setState(() {});
  }

  _toggleAnalytics(bool value) async {
    await UserPreferences().setAnalyticsEnabled(value);
  }

  _initAppLanguage() async {
    var _prefLang = await UserPreferences().getUserPrefLanguage();
    _prefLang == null
        ? setState((){ _indexSelected = 0; })
        : (_prefLang.split('_').first == "fr")
          ? setState((){ _indexSelected = 1; })
          : setState((){ _indexSelected = 0; });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(context,
      title: S.of(context).homePagePageSliverListSettings,
      showShareBottomBar: false,
      body: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: ListTile(
                leading: Text(
                  S.of(context).homePagePageSliverListSettingsHeader1,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700,),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Text(
                S.of(context).homePagePageSliverListSettingsDataCollection,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.0),
              child: Text(
                S.of(context).homePagePageSliverListSettingsHeader2,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
              child: ChoiceChip(
                selectedColor: _indexSelected == 0 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("English", style: TextStyle(color: _indexSelected == 0 ? Colors.white : Colors.black),),
                  trailing: _indexSelected == 0 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: _indexSelected == 0,
                onSelected: (value){
                  UserPreferences().setUserPrefLanguage("en_US");
                  setState(() {
                    S.delegate.load(Locale('en', 'US'));
                    if(value) _indexSelected = 0;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
              child: ChoiceChip(
                selectedColor: _indexSelected == 1 ? Constants.primaryColor : Colors.grey[300],
                label: ListTile(
                  title: Text("French", style: TextStyle(color: _indexSelected == 1 ? Colors.white : Colors.black),),
                  trailing: _indexSelected == 1 ? Icon(Icons.check, color: Colors.white,) : null,
                ),
                selected: _indexSelected == 1,
                onSelected: (value){
                  UserPreferences().setUserPrefLanguage("fr_FR");
                  setState(() {
                    S.delegate.load(Locale('fr', 'FR'));
                    if(value) _indexSelected = 1;
                  });
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}