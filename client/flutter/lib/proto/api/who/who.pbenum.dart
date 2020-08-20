///
//  Generated code. Do not modify.
//  source: api/who/who.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class JurisdictionType extends $pb.ProtobufEnum {
  static const JurisdictionType GLOBAL = JurisdictionType._(0, 'GLOBAL');
  static const JurisdictionType WHO_REGION =
      JurisdictionType._(1, 'WHO_REGION');
  static const JurisdictionType COUNTRY = JurisdictionType._(2, 'COUNTRY');

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
  static const Platform IOS = Platform._(0, 'IOS');
  static const Platform ANDROID = Platform._(1, 'ANDROID');
  static const Platform WEB = Platform._(2, 'WEB');

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
