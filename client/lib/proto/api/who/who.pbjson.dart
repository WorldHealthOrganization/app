///
//  Generated code. Do not modify.
//  source: api/who/who.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const JurisdictionType$json = const {
  '1': 'JurisdictionType',
  '2': const [
    const {'1': 'GLOBAL', '2': 0},
    const {'1': 'WHO_REGION', '2': 1},
    const {'1': 'COUNTRY', '2': 2},
  ],
};

const Platform$json = const {
  '1': 'Platform',
  '2': const [
    const {'1': 'IOS', '2': 0},
    const {'1': 'ANDROID', '2': 1},
    const {'1': 'WEB', '2': 2},
  ],
};

const Void$json = const {
  '1': 'Void',
};

const PutDeviceTokenRequest$json = const {
  '1': 'PutDeviceTokenRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

const PutLocationRequest$json = const {
  '1': 'PutLocationRequest',
  '2': const [
    const {
      '1': 'isoCountryCode',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'isoCountryCode'
    },
  ],
};

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

const WhoServiceBase$json = const {
  '1': 'WhoService',
  '2': const [
    const {
      '1': 'putDeviceToken',
      '2': '.who.PutDeviceTokenRequest',
      '3': '.who.Void'
    },
    const {
      '1': 'putLocation',
      '2': '.who.PutLocationRequest',
      '3': '.who.Void'
    },
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

const WhoServiceBase$messageJson = const {
  '.who.PutDeviceTokenRequest': PutDeviceTokenRequest$json,
  '.who.Void': Void$json,
  '.who.PutLocationRequest': PutLocationRequest$json,
  '.who.PutClientSettingsRequest': PutClientSettingsRequest$json,
  '.who.GetCaseStatsRequest': GetCaseStatsRequest$json,
  '.who.JurisdictionId': JurisdictionId$json,
  '.who.GetCaseStatsResponse': GetCaseStatsResponse$json,
  '.who.CaseStats': CaseStats$json,
  '.who.StatSnapshot': StatSnapshot$json,
};
