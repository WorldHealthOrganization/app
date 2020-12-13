///
//  Generated code. Do not modify.
//  source: api/who/who.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'who.pb.dart' as $0;
import 'who.pbjson.dart';

export 'who.pb.dart';

abstract class WhoServiceBase extends $pb.GeneratedService {
  $async.Future<$0.Void> putDeviceToken(
      $pb.ServerContext ctx, $0.PutDeviceTokenRequest request);
  $async.Future<$0.Void> putLocation(
      $pb.ServerContext ctx, $0.PutLocationRequest request);
  $async.Future<$0.Void> putClientSettings(
      $pb.ServerContext ctx, $0.PutClientSettingsRequest request);
  $async.Future<$0.GetCaseStatsResponse> getCaseStats(
      $pb.ServerContext ctx, $0.GetCaseStatsRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'putDeviceToken':
        return $0.PutDeviceTokenRequest();
      case 'putLocation':
        return $0.PutLocationRequest();
      case 'putClientSettings':
        return $0.PutClientSettingsRequest();
      case 'getCaseStats':
        return $0.GetCaseStatsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'putDeviceToken':
        return this.putDeviceToken(ctx, request);
      case 'putLocation':
        return this.putLocation(ctx, request);
      case 'putClientSettings':
        return this.putClientSettings(ctx, request);
      case 'getCaseStats':
        return this.getCaseStats(ctx, request);
      default:
        throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => WhoServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => WhoServiceBase$messageJson;
}
