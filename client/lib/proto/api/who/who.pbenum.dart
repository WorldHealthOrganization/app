///
//  Generated code. Do not modify.
//  source: api/who/who.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class JurisdictionType extends $pb.ProtobufEnum {
  static const JurisdictionType GLOBAL = JurisdictionType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'GLOBAL');
  static const JurisdictionType WHO_REGION = JurisdictionType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'WHO_REGION');
  static const JurisdictionType COUNTRY = JurisdictionType._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'COUNTRY');

  static const $core.List<JurisdictionType> values = <JurisdictionType>[
    GLOBAL,
    WHO_REGION,
    COUNTRY,
  ];

  static final $core.Map<$core.int, JurisdictionType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static JurisdictionType valueOf($core.int value) => _byValue[value];

  const JurisdictionType._($core.int v, $core.String n) : super(v, n);
}

class Platform extends $pb.ProtobufEnum {
  static const Platform IOS = Platform._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'IOS');
  static const Platform ANDROID = Platform._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ANDROID');
  static const Platform WEB = Platform._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'WEB');

  static const $core.List<Platform> values = <Platform>[
    IOS,
    ANDROID,
    WEB,
  ];

  static final $core.Map<$core.int, Platform> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Platform valueOf($core.int value) => _byValue[value];

  const Platform._($core.int v, $core.String n) : super(v, n);
}
