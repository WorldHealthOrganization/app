// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StatsStore on _StatsStore, Store {
  Computed<CaseStats> _$globalStatsComputed;

  @override
  CaseStats get globalStats =>
      (_$globalStatsComputed ??= Computed<CaseStats>(() => super.globalStats,
              name: '_StatsStore.globalStats'))
          .value;
  Computed<int> _$globalCasesComputed;

  @override
  int get globalCases =>
      (_$globalCasesComputed ??= Computed<int>(() => super.globalCases,
              name: '_StatsStore.globalCases'))
          .value;
  Computed<CaseStats> _$countryStatsComputed;

  @override
  CaseStats get countryStats =>
      (_$countryStatsComputed ??= Computed<CaseStats>(() => super.countryStats,
              name: '_StatsStore.countryStats'))
          .value;
  Computed<int> _$countryCasesComputed;

  @override
  int get countryCases =>
      (_$countryCasesComputed ??= Computed<int>(() => super.countryCases,
              name: '_StatsStore.countryCases'))
          .value;
  Computed<int> _$countryDailyCasesComputed;

  @override
  int get countryDailyCases => (_$countryDailyCasesComputed ??= Computed<int>(
          () => super.countryDailyCases,
          name: '_StatsStore.countryDailyCases'))
      .value;
  Computed<int> _$globalDailyCasesComputed;

  @override
  int get globalDailyCases => (_$globalDailyCasesComputed ??= Computed<int>(
          () => super.globalDailyCases,
          name: '_StatsStore.globalDailyCases'))
      .value;

  final _$caseStatsResponseAtom = Atom(name: '_StatsStore.caseStatsResponse');

  @override
  GetCaseStatsResponse get caseStatsResponse {
    _$caseStatsResponseAtom.reportRead();
    return super.caseStatsResponse;
  }

  @override
  set caseStatsResponse(GetCaseStatsResponse value) {
    _$caseStatsResponseAtom.reportWrite(value, super.caseStatsResponse, () {
      super.caseStatsResponse = value;
    });
  }

  final _$updateAsyncAction = AsyncAction('_StatsStore.update');

  @override
  Future<void> update() {
    return _$updateAsyncAction.run(() => super.update());
  }

  @override
  String toString() {
    return '''
caseStatsResponse: ${caseStatsResponse},
globalStats: ${globalStats},
globalCases: ${globalCases},
countryStats: ${countryStats},
countryCases: ${countryCases},
countryDailyCases: ${countryDailyCases},
globalDailyCases: ${globalDailyCases}
    ''';
  }
}
