import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/components/page_scaffold/page_scaffold.dart';
import 'package:who_app/constants.dart';
import 'package:who_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///========================================================
/// TODO SUMMARY:
///   1. User title and subtitle texts from generated
///      file (already generated)
///=========================================================

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _analyticsEnabled;
  int indexSelected = 0;

  @override
  void initState() {
    super.initState();
    if (_analyticsEnabled == null) {
      _initAnalyticsSwitch();
    }
  }

  _initAnalyticsSwitch() async {
    _analyticsEnabled = await UserPreferences().getAnalyticsEnabled();
    setState(() {});
  }

  _toggleAnalytics(bool value) async {
    await UserPreferences().setAnalyticsEnabled(value);
    setState(() {
      _analyticsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: [
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Semantics(
                  toggled: _analyticsEnabled,
                  child: InkWell(
                    onTap: () => _toggleAnalytics(!_analyticsEnabled),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  S
                                      .of(context)
                                      .homePagePageSliverListSettingsHeader1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Semantics(
                                excludeSemantics: true,
                                child: CupertinoSwitch(
                                  activeColor: Constants.primaryColor,
                                  value: _analyticsEnabled ?? false,
                                  onChanged: _toggleAnalytics,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            S
                                .of(context)
                                .homePagePageSliverListSettingsDataCollection,
                            style: Theme.of(context).textTheme.subhead,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                /// TODO: Implement UI:-
                /// TODO:   selection of language preferences already created PR for it (#654)
              ],
            ),
          ],
        ))
      ],
      title: S.of(context).homePagePageSliverListSettings,
    );
  }
}
