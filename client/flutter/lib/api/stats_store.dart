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
  StatsStore({@required WhoService service}) : super(service: service);
}

abstract class _StatsStore with Store implements Updateable {
  final WhoService service;

  _StatsStore({@required this.service});

  @observable
  GetCaseStatsResponse caseStatsResponse;

  @computed
  CaseStats get globalStats {
    // ignore: deprecated_member_use_from_same_package
    return caseStatsResponse?.globalStats;
  }

  @computed
  int get globalCases {
    return globalStats?.cases?.toInt();
  }

  @action
  Future<void> update() async {
    // TODO: UserPreferences should be injected dependency.
    if (!await UserPreferences().getTermsOfServiceCompleted()) {
      print('StatsStore update skipped');
      return;
    }
    print('StatsStore update');
    /** How to test that the periodic updating works:
    final caseStatsResponse2 = await service.getCaseStats();
    caseStatsResponse2.globalStats.cases = Int64(caseStatsResponse2.globalStats.cases.toInt() + Random().nextInt(100000));
    caseStatsResponse = caseStatsResponse2;
    */
    caseStatsResponse = await service.getCaseStats();
  }
}
