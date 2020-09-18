import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:who_app/api/updateable.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/proto/api/who/who.pb.dart';

// Whenever this file is modified, regenerate the .g.dart file using the command:
// flutter packages pub run build_runner build
part 'stats_store.g.dart';

class StatsStore extends _StatsStore with _$StatsStore {
  StatsStore({@required WhoService service, @required String countryIsoCode})
      : super(service: service, countryIsoCode: countryIsoCode);
}

abstract class _StatsStore with Store implements Updateable {
  final WhoService service;
  final String countryIsoCode;

  _StatsStore({@required this.service, @required this.countryIsoCode});

  @observable
  GetCaseStatsResponse caseStatsResponse;

  @computed
  CaseStats get globalStats {
    return caseStatsResponse?.jurisdictionStats?.first;
  }

  @computed
  int get globalCases {
    return globalStats?.cases?.toInt();
  }

  @computed
  CaseStats get countryStats {
    return caseStatsResponse?.jurisdictionStats?.last;
  }

  @computed
  int get countryCases {
    return countryStats?.cases?.toInt();
  }

  @action
  Future<void> update() async {
    // TODO: UserPreferences should be injected dependency.
    if (!await UserPreferences().getTermsOfServiceCompleted()) {
      print('StatsStore update skipped');
      return;
    }
    print('StatsStore update with country ${countryIsoCode}');
    /** How to test that the periodic updating works:
    final caseStatsResponse2 = await service.getCaseStats(isoCountryCode: countryIsoCode);
    caseStatsResponse2.globalStats.cases = Int64(caseStatsResponse2.globalStats.cases.toInt() + Random().nextInt(100000));
    caseStatsResponse = caseStatsResponse2;
    */
    caseStatsResponse =
        await service.getCaseStats(isoCountryCode: countryIsoCode);
  }
}
