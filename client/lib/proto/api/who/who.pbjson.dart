///
//  Generated code. Do not modify.
//  source: api/who/who.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use jurisdictionTypeDescriptor instead')
const JurisdictionType$json = const {
  '1': 'JurisdictionType',
  '2': const [
    const {'1': 'GLOBAL', '2': 0},
    const {'1': 'WHO_REGION', '2': 1},
    const {'1': 'COUNTRY', '2': 2},
  ],
};

/// Descriptor for `JurisdictionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List jurisdictionTypeDescriptor = $convert.base64Decode(
    'ChBKdXJpc2RpY3Rpb25UeXBlEgoKBkdMT0JBTBAAEg4KCldIT19SRUdJT04QARILCgdDT1VOVFJZEAI=');
@$core.Deprecated('Use platformDescriptor instead')
const Platform$json = const {
  '1': 'Platform',
  '2': const [
    const {'1': 'IOS', '2': 0},
    const {'1': 'ANDROID', '2': 1},
    const {'1': 'WEB', '2': 2},
  ],
};

/// Descriptor for `Platform`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List platformDescriptor = $convert
    .base64Decode('CghQbGF0Zm9ybRIHCgNJT1MQABILCgdBTkRST0lEEAESBwoDV0VCEAI=');
@$core.Deprecated('Use voidDescriptor instead')
const Void$json = const {
  '1': 'Void',
};

/// Descriptor for `Void`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voidDescriptor = $convert.base64Decode('CgRWb2lk');
@$core.Deprecated('Use putClientSettingsRequestDescriptor instead')
const PutClientSettingsRequest$json = const {
  '1': 'PutClientSettingsRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    const {
      '1': 'isoCountryCode',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'isoCountryCode'
    },
  ],
};

/// Descriptor for `PutClientSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putClientSettingsRequestDescriptor =
    $convert.base64Decode(
        'ChhQdXRDbGllbnRTZXR0aW5nc1JlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2VuEiYKDmlzb0NvdW50cnlDb2RlGAwgASgJUg5pc29Db3VudHJ5Q29kZQ==');
@$core.Deprecated('Use jurisdictionIdDescriptor instead')
const JurisdictionId$json = const {
  '1': 'JurisdictionId',
  '2': const [
    const {
      '1': 'jurisdictionType',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.who.JurisdictionType',
      '10': 'jurisdictionType'
    },
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `JurisdictionId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jurisdictionIdDescriptor = $convert.base64Decode(
    'Cg5KdXJpc2RpY3Rpb25JZBJBChBqdXJpc2RpY3Rpb25UeXBlGAIgASgOMhUud2hvLkp1cmlzZGljdGlvblR5cGVSEGp1cmlzZGljdGlvblR5cGUSEgoEY29kZRgBIAEoCVIEY29kZQ==');
@$core.Deprecated('Use getCaseStatsRequestDescriptor instead')
const GetCaseStatsRequest$json = const {
  '1': 'GetCaseStatsRequest',
  '2': const [
    const {
      '1': 'jurisdictions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.who.JurisdictionId',
      '10': 'jurisdictions'
    },
  ],
};

/// Descriptor for `GetCaseStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCaseStatsRequestDescriptor = $convert.base64Decode(
    'ChNHZXRDYXNlU3RhdHNSZXF1ZXN0EjkKDWp1cmlzZGljdGlvbnMYASADKAsyEy53aG8uSnVyaXNkaWN0aW9uSWRSDWp1cmlzZGljdGlvbnM=');
@$core.Deprecated('Use getCaseStatsResponseDescriptor instead')
const GetCaseStatsResponse$json = const {
  '1': 'GetCaseStatsResponse',
  '2': const [
    const {
      '1': 'globalStats',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.who.CaseStats',
      '8': const {'3': true},
      '10': 'globalStats',
    },
    const {
      '1': 'jurisdictionStats',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.who.CaseStats',
      '10': 'jurisdictionStats'
    },
    const {'1': 'ttl', '3': 2, '4': 1, '5': 4, '10': 'ttl'},
  ],
};

/// Descriptor for `GetCaseStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCaseStatsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRDYXNlU3RhdHNSZXNwb25zZRI0CgtnbG9iYWxTdGF0cxgBIAEoCzIOLndoby5DYXNlU3RhdHNCAhgBUgtnbG9iYWxTdGF0cxI8ChFqdXJpc2RpY3Rpb25TdGF0cxgDIAMoCzIOLndoby5DYXNlU3RhdHNSEWp1cmlzZGljdGlvblN0YXRzEhAKA3R0bBgCIAEoBFIDdHRs');
@$core.Deprecated('Use statSnapshotDescriptor instead')
const StatSnapshot$json = const {
  '1': 'StatSnapshot',
  '2': const [
    const {'1': 'epochMsec', '3': 1, '4': 1, '5': 4, '10': 'epochMsec'},
    const {'1': 'dailyCases', '3': 2, '4': 1, '5': 3, '10': 'dailyCases'},
    const {'1': 'dailyDeaths', '3': 3, '4': 1, '5': 3, '10': 'dailyDeaths'},
    const {
      '1': 'dailyRecoveries',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'dailyRecoveries'
    },
    const {'1': 'totalCases', '3': 5, '4': 1, '5': 3, '10': 'totalCases'},
    const {'1': 'totalDeaths', '3': 6, '4': 1, '5': 3, '10': 'totalDeaths'},
    const {
      '1': 'totalRecoveries',
      '3': 7,
      '4': 1,
      '5': 3,
      '10': 'totalRecoveries'
    },
  ],
};

/// Descriptor for `StatSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statSnapshotDescriptor = $convert.base64Decode(
    'CgxTdGF0U25hcHNob3QSHAoJZXBvY2hNc2VjGAEgASgEUgllcG9jaE1zZWMSHgoKZGFpbHlDYXNlcxgCIAEoA1IKZGFpbHlDYXNlcxIgCgtkYWlseURlYXRocxgDIAEoA1ILZGFpbHlEZWF0aHMSKAoPZGFpbHlSZWNvdmVyaWVzGAQgASgDUg9kYWlseVJlY292ZXJpZXMSHgoKdG90YWxDYXNlcxgFIAEoA1IKdG90YWxDYXNlcxIgCgt0b3RhbERlYXRocxgGIAEoA1ILdG90YWxEZWF0aHMSKAoPdG90YWxSZWNvdmVyaWVzGAcgASgDUg90b3RhbFJlY292ZXJpZXM=');
@$core.Deprecated('Use caseStatsDescriptor instead')
const CaseStats$json = const {
  '1': 'CaseStats',
  '2': const [
    const {
      '1': 'jurisdictionType',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.who.JurisdictionType',
      '10': 'jurisdictionType'
    },
    const {'1': 'jurisdiction', '3': 1, '4': 1, '5': 9, '10': 'jurisdiction'},
    const {'1': 'lastUpdated', '3': 2, '4': 1, '5': 4, '10': 'lastUpdated'},
    const {'1': 'cases', '3': 3, '4': 1, '5': 3, '10': 'cases'},
    const {'1': 'deaths', '3': 4, '4': 1, '5': 3, '10': 'deaths'},
    const {'1': 'recoveries', '3': 5, '4': 1, '5': 3, '10': 'recoveries'},
    const {'1': 'attribution', '3': 6, '4': 1, '5': 9, '10': 'attribution'},
    const {
      '1': 'timeseries',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.who.StatSnapshot',
      '10': 'timeseries'
    },
  ],
};

/// Descriptor for `CaseStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List caseStatsDescriptor = $convert.base64Decode(
    'CglDYXNlU3RhdHMSQQoQanVyaXNkaWN0aW9uVHlwZRgHIAEoDjIVLndoby5KdXJpc2RpY3Rpb25UeXBlUhBqdXJpc2RpY3Rpb25UeXBlEiIKDGp1cmlzZGljdGlvbhgBIAEoCVIManVyaXNkaWN0aW9uEiAKC2xhc3RVcGRhdGVkGAIgASgEUgtsYXN0VXBkYXRlZBIUCgVjYXNlcxgDIAEoA1IFY2FzZXMSFgoGZGVhdGhzGAQgASgDUgZkZWF0aHMSHgoKcmVjb3ZlcmllcxgFIAEoA1IKcmVjb3ZlcmllcxIgCgthdHRyaWJ1dGlvbhgGIAEoCVILYXR0cmlidXRpb24SMQoKdGltZXNlcmllcxgIIAMoCzIRLndoby5TdGF0U25hcHNob3RSCnRpbWVzZXJpZXM=');
const WhoServiceBase$json = const {
  '1': 'WhoService',
  '2': const [
    const {
      '1': 'putClientSettings',
      '2': '.who.PutClientSettingsRequest',
      '3': '.who.Void'
    },
    const {
      '1': 'getCaseStats',
      '2': '.who.GetCaseStatsRequest',
      '3': '.who.GetCaseStatsResponse'
    },
  ],
};

@$core.Deprecated('Use whoServiceDescriptor instead')
const WhoServiceBase$messageJson = const {
  '.who.PutClientSettingsRequest': PutClientSettingsRequest$json,
  '.who.Void': Void$json,
  '.who.GetCaseStatsRequest': GetCaseStatsRequest$json,
  '.who.JurisdictionId': JurisdictionId$json,
  '.who.GetCaseStatsResponse': GetCaseStatsResponse$json,
  '.who.CaseStats': CaseStats$json,
  '.who.StatSnapshot': StatSnapshot$json,
};

/// Descriptor for `WhoService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List whoServiceDescriptor = $convert.base64Decode(
    'CgpXaG9TZXJ2aWNlEj0KEXB1dENsaWVudFNldHRpbmdzEh0ud2hvLlB1dENsaWVudFNldHRpbmdzUmVxdWVzdBoJLndoby5Wb2lkEkMKDGdldENhc2VTdGF0cxIYLndoby5HZXRDYXNlU3RhdHNSZXF1ZXN0Ghkud2hvLkdldENhc2VTdGF0c1Jlc3BvbnNl');
