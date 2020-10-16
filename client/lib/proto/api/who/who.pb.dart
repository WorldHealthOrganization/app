///
//  Generated code. Do not modify.
//  source: api/who/who.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'who.pbenum.dart';

export 'who.pbenum.dart';

class Void extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Void',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..hasRequiredFields = false;

  Void._() : super();
  factory Void() => create();
  factory Void.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Void.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Void clone() => Void()..mergeFromMessage(this);
  Void copyWith(void Function(Void) updates) =>
      super.copyWith((message) => updates(message as Void));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Void create() => Void._();
  Void createEmptyInstance() => create();
  static $pb.PbList<Void> createRepeated() => $pb.PbList<Void>();
  @$core.pragma('dart2js:noInline')
  static Void getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Void>(create);
  static Void _defaultInstance;
}

class PutDeviceTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PutDeviceTokenRequest',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..aOS(1, 'token')
    ..hasRequiredFields = false;

  PutDeviceTokenRequest._() : super();
  factory PutDeviceTokenRequest() => create();
  factory PutDeviceTokenRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PutDeviceTokenRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  PutDeviceTokenRequest clone() =>
      PutDeviceTokenRequest()..mergeFromMessage(this);
  PutDeviceTokenRequest copyWith(
          void Function(PutDeviceTokenRequest) updates) =>
      super.copyWith((message) => updates(message as PutDeviceTokenRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PutDeviceTokenRequest create() => PutDeviceTokenRequest._();
  PutDeviceTokenRequest createEmptyInstance() => create();
  static $pb.PbList<PutDeviceTokenRequest> createRepeated() =>
      $pb.PbList<PutDeviceTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static PutDeviceTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PutDeviceTokenRequest>(create);
  static PutDeviceTokenRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
}

class PutLocationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PutLocationRequest',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..aOS(12, 'isoCountryCode', protoName: 'isoCountryCode')
    ..hasRequiredFields = false;

  PutLocationRequest._() : super();
  factory PutLocationRequest() => create();
  factory PutLocationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PutLocationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  PutLocationRequest clone() => PutLocationRequest()..mergeFromMessage(this);
  PutLocationRequest copyWith(void Function(PutLocationRequest) updates) =>
      super.copyWith((message) => updates(message as PutLocationRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PutLocationRequest create() => PutLocationRequest._();
  PutLocationRequest createEmptyInstance() => create();
  static $pb.PbList<PutLocationRequest> createRepeated() =>
      $pb.PbList<PutLocationRequest>();
  @$core.pragma('dart2js:noInline')
  static PutLocationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PutLocationRequest>(create);
  static PutLocationRequest _defaultInstance;

  @$pb.TagNumber(12)
  $core.String get isoCountryCode => $_getSZ(0);
  @$pb.TagNumber(12)
  set isoCountryCode($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasIsoCountryCode() => $_has(0);
  @$pb.TagNumber(12)
  void clearIsoCountryCode() => clearField(12);
}

class JurisdictionId extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('JurisdictionId',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..aOS(1, 'code')
    ..e<JurisdictionType>(2, 'jurisdictionType', $pb.PbFieldType.OE,
        protoName: 'jurisdictionType',
        defaultOrMaker: JurisdictionType.GLOBAL,
        valueOf: JurisdictionType.valueOf,
        enumValues: JurisdictionType.values)
    ..hasRequiredFields = false;

  JurisdictionId._() : super();
  factory JurisdictionId() => create();
  factory JurisdictionId.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JurisdictionId.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  JurisdictionId clone() => JurisdictionId()..mergeFromMessage(this);
  JurisdictionId copyWith(void Function(JurisdictionId) updates) =>
      super.copyWith((message) => updates(message as JurisdictionId));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JurisdictionId create() => JurisdictionId._();
  JurisdictionId createEmptyInstance() => create();
  static $pb.PbList<JurisdictionId> createRepeated() =>
      $pb.PbList<JurisdictionId>();
  @$core.pragma('dart2js:noInline')
  static JurisdictionId getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JurisdictionId>(create);
  static JurisdictionId _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  JurisdictionType get jurisdictionType => $_getN(1);
  @$pb.TagNumber(2)
  set jurisdictionType(JurisdictionType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasJurisdictionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearJurisdictionType() => clearField(2);
}

class GetCaseStatsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetCaseStatsRequest',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..pc<JurisdictionId>(1, 'jurisdictions', $pb.PbFieldType.PM,
        subBuilder: JurisdictionId.create)
    ..hasRequiredFields = false;

  GetCaseStatsRequest._() : super();
  factory GetCaseStatsRequest() => create();
  factory GetCaseStatsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCaseStatsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  GetCaseStatsRequest clone() => GetCaseStatsRequest()..mergeFromMessage(this);
  GetCaseStatsRequest copyWith(void Function(GetCaseStatsRequest) updates) =>
      super.copyWith((message) => updates(message as GetCaseStatsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCaseStatsRequest create() => GetCaseStatsRequest._();
  GetCaseStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCaseStatsRequest> createRepeated() =>
      $pb.PbList<GetCaseStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCaseStatsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCaseStatsRequest>(create);
  static GetCaseStatsRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<JurisdictionId> get jurisdictions => $_getList(0);
}

class GetCaseStatsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GetCaseStatsResponse',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..aOM<CaseStats>(1, 'globalStats',
        protoName: 'globalStats', subBuilder: CaseStats.create)
    ..a<$fixnum.Int64>(2, 'ttl', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<CaseStats>(3, 'jurisdictionStats', $pb.PbFieldType.PM,
        protoName: 'jurisdictionStats', subBuilder: CaseStats.create)
    ..hasRequiredFields = false;

  GetCaseStatsResponse._() : super();
  factory GetCaseStatsResponse() => create();
  factory GetCaseStatsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCaseStatsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  GetCaseStatsResponse clone() =>
      GetCaseStatsResponse()..mergeFromMessage(this);
  GetCaseStatsResponse copyWith(void Function(GetCaseStatsResponse) updates) =>
      super.copyWith((message) => updates(message as GetCaseStatsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCaseStatsResponse create() => GetCaseStatsResponse._();
  GetCaseStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCaseStatsResponse> createRepeated() =>
      $pb.PbList<GetCaseStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCaseStatsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCaseStatsResponse>(create);
  static GetCaseStatsResponse _defaultInstance;

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  CaseStats get globalStats => $_getN(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set globalStats(CaseStats v) {
    setField(1, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasGlobalStats() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearGlobalStats() => clearField(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  CaseStats ensureGlobalStats() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get ttl => $_getI64(1);
  @$pb.TagNumber(2)
  set ttl($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTtl() => $_has(1);
  @$pb.TagNumber(2)
  void clearTtl() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<CaseStats> get jurisdictionStats => $_getList(2);
}

class StatSnapshot extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatSnapshot',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'epochMsec', $pb.PbFieldType.OU6,
        protoName: 'epochMsec', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(2, 'dailyCases', protoName: 'dailyCases')
    ..aInt64(3, 'dailyDeaths', protoName: 'dailyDeaths')
    ..aInt64(4, 'dailyRecoveries', protoName: 'dailyRecoveries')
    ..aInt64(5, 'totalCases', protoName: 'totalCases')
    ..aInt64(6, 'totalDeaths', protoName: 'totalDeaths')
    ..aInt64(7, 'totalRecoveries', protoName: 'totalRecoveries')
    ..hasRequiredFields = false;

  StatSnapshot._() : super();
  factory StatSnapshot() => create();
  factory StatSnapshot.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StatSnapshot.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  StatSnapshot clone() => StatSnapshot()..mergeFromMessage(this);
  StatSnapshot copyWith(void Function(StatSnapshot) updates) =>
      super.copyWith((message) => updates(message as StatSnapshot));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatSnapshot create() => StatSnapshot._();
  StatSnapshot createEmptyInstance() => create();
  static $pb.PbList<StatSnapshot> createRepeated() =>
      $pb.PbList<StatSnapshot>();
  @$core.pragma('dart2js:noInline')
  static StatSnapshot getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatSnapshot>(create);
  static StatSnapshot _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epochMsec => $_getI64(0);
  @$pb.TagNumber(1)
  set epochMsec($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEpochMsec() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochMsec() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get dailyCases => $_getI64(1);
  @$pb.TagNumber(2)
  set dailyCases($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDailyCases() => $_has(1);
  @$pb.TagNumber(2)
  void clearDailyCases() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get dailyDeaths => $_getI64(2);
  @$pb.TagNumber(3)
  set dailyDeaths($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDailyDeaths() => $_has(2);
  @$pb.TagNumber(3)
  void clearDailyDeaths() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get dailyRecoveries => $_getI64(3);
  @$pb.TagNumber(4)
  set dailyRecoveries($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDailyRecoveries() => $_has(3);
  @$pb.TagNumber(4)
  void clearDailyRecoveries() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalCases => $_getI64(4);
  @$pb.TagNumber(5)
  set totalCases($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTotalCases() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalCases() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDeaths => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDeaths($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTotalDeaths() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDeaths() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalRecoveries => $_getI64(6);
  @$pb.TagNumber(7)
  set totalRecoveries($fixnum.Int64 v) {
    $_setInt64(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasTotalRecoveries() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalRecoveries() => clearField(7);
}

class CaseStats extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CaseStats',
      package: const $pb.PackageName('who'), createEmptyInstance: create)
    ..aOS(1, 'jurisdiction')
    ..a<$fixnum.Int64>(2, 'lastUpdated', $pb.PbFieldType.OU6,
        protoName: 'lastUpdated', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(3, 'cases')
    ..aInt64(4, 'deaths')
    ..aInt64(5, 'recoveries')
    ..aOS(6, 'attribution')
    ..e<JurisdictionType>(7, 'jurisdictionType', $pb.PbFieldType.OE,
        protoName: 'jurisdictionType',
        defaultOrMaker: JurisdictionType.GLOBAL,
        valueOf: JurisdictionType.valueOf,
        enumValues: JurisdictionType.values)
    ..pc<StatSnapshot>(8, 'timeseries', $pb.PbFieldType.PM,
        subBuilder: StatSnapshot.create)
    ..hasRequiredFields = false;

  CaseStats._() : super();
  factory CaseStats() => create();
  factory CaseStats.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CaseStats.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  CaseStats clone() => CaseStats()..mergeFromMessage(this);
  CaseStats copyWith(void Function(CaseStats) updates) =>
      super.copyWith((message) => updates(message as CaseStats));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CaseStats create() => CaseStats._();
  CaseStats createEmptyInstance() => create();
  static $pb.PbList<CaseStats> createRepeated() => $pb.PbList<CaseStats>();
  @$core.pragma('dart2js:noInline')
  static CaseStats getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CaseStats>(create);
  static CaseStats _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get jurisdiction => $_getSZ(0);
  @$pb.TagNumber(1)
  set jurisdiction($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasJurisdiction() => $_has(0);
  @$pb.TagNumber(1)
  void clearJurisdiction() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lastUpdated => $_getI64(1);
  @$pb.TagNumber(2)
  set lastUpdated($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLastUpdated() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastUpdated() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get cases => $_getI64(2);
  @$pb.TagNumber(3)
  set cases($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCases() => $_has(2);
  @$pb.TagNumber(3)
  void clearCases() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get deaths => $_getI64(3);
  @$pb.TagNumber(4)
  set deaths($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDeaths() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeaths() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get recoveries => $_getI64(4);
  @$pb.TagNumber(5)
  set recoveries($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasRecoveries() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecoveries() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get attribution => $_getSZ(5);
  @$pb.TagNumber(6)
  set attribution($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasAttribution() => $_has(5);
  @$pb.TagNumber(6)
  void clearAttribution() => clearField(6);

  @$pb.TagNumber(7)
  JurisdictionType get jurisdictionType => $_getN(6);
  @$pb.TagNumber(7)
  set jurisdictionType(JurisdictionType v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasJurisdictionType() => $_has(6);
  @$pb.TagNumber(7)
  void clearJurisdictionType() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<StatSnapshot> get timeseries => $_getList(7);
}

class WhoServiceApi {
  $pb.RpcClient _client;
  WhoServiceApi(this._client);

  $async.Future<Void> putDeviceToken(
      $pb.ClientContext ctx, PutDeviceTokenRequest request) {
    var emptyResponse = Void();
    return _client.invoke<Void>(
        ctx, 'WhoService', 'putDeviceToken', request, emptyResponse);
  }

  $async.Future<Void> putLocation(
      $pb.ClientContext ctx, PutLocationRequest request) {
    var emptyResponse = Void();
    return _client.invoke<Void>(
        ctx, 'WhoService', 'putLocation', request, emptyResponse);
  }

  $async.Future<GetCaseStatsResponse> getCaseStats(
      $pb.ClientContext ctx, GetCaseStatsRequest request) {
    var emptyResponse = GetCaseStatsResponse();
    return _client.invoke<GetCaseStatsResponse>(
        ctx, 'WhoService', 'getCaseStats', request, emptyResponse);
  }
}
