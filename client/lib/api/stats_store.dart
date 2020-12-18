import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:who_app/api/updateable.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/api/user_preferences_store.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/proto/api/who/who.pb.dart';

// Whenever this file is modified, regenerate the .g.dart file using the command:
// flutter packages pub run build_runner build
part 'stats_store.g.dart';

class StatsStore extends _StatsStore with _$StatsStore {
  StatsStore(
      {@required WhoService service, @required UserPreferencesStore prefs})
      : super(service: service, prefs: prefs);
}

abstract class _StatsStore with Store implements Updateable {
  final WhoService service;
  final UserPreferencesStore prefs;

  _StatsStore({@required this.service, @required this.prefs});

  @observable
  GetCaseStatsResponse caseStatsResponse;

  // Last update millisecondsSinceEpoch.
  int _lastUpdateTimestamp = 0;
  // Last seen user preference.
  String countryIsoCode;

  // One hour cache.
  static int statsUpdateFrequency = 60 * 60 * 1000;

  @computed
  CaseStats get globalStats {
    final statsList = caseStatsResponse?.jurisdictionStats ?? [];
    return statsList.isEmpty ? null : statsList.first;
  }

  @computed
  int get globalCases {
    return globalStats?.cases?.toInt();
  }

  @computed
  CaseStats get countryStats {
    final statsList = caseStatsResponse?.jurisdictionStats ?? [];
    return statsList.isEmpty ? null : statsList.last;
  }

  @computed
  int get countryCases {
    return countryStats?.cases?.toInt();
  }

  @computed
  int get countryDailyCases =>
      countryStats?.timeseries?.last?.dailyCases?.toInt();

  @computed
  int get globalDailyCases =>
      globalStats?.timeseries?.last?.dailyCases?.toInt();

  @action
  @override
  Future<void> update() async {
    // TODO: UserPreferences should be injected dependency.
    if (!await UserPreferences().getTermsOfServiceCompleted()) {
      print('StatsStore update skipped');
      return;
    }

    var now = DateTime.now().millisecondsSinceEpoch;
    var delta = now - _lastUpdateTimestamp;
    if (delta < statsUpdateFrequency &&
        countryIsoCode == prefs.countryIsoCode) {
      print('StatsStore update skipped, cached data used from ${delta}ms ago.');
      return;
    }

    countryIsoCode = prefs.countryIsoCode;
    if (countryIsoCode == null) {
      // This happens at startup time (while the prefs are being loaded in?).
      print('StatsStore update skipped, country unknown.');
      return;
    }

    print('StatsStore update with country ${countryIsoCode}, '
        'refreshing data last seen ${delta}ms ago.');

    caseStatsResponse =
        await service.getCaseStats(isoCountryCode: countryIsoCode);
    _lastUpdateTimestamp = now;
  }
}
