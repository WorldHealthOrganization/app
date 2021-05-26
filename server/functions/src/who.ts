/* eslint-disable */

// This was generated from who.proto with https://github.com/stephenh/ts-proto
// Then all of the encoding methods were removed as they interfered with
// Firestore and are not necessary.
// This leaves only the interface definitions.

export const protobufPackage = "who";

export enum JurisdictionType {
  GLOBAL = 0,
  WHO_REGION = 1,
  COUNTRY = 2,
  UNRECOGNIZED = -1,
}

export function jurisdictionTypeFromJSON(object: any): JurisdictionType {
  switch (object) {
    case 0:
    case "GLOBAL":
      return JurisdictionType.GLOBAL;
    case 1:
    case "WHO_REGION":
      return JurisdictionType.WHO_REGION;
    case 2:
    case "COUNTRY":
      return JurisdictionType.COUNTRY;
    case -1:
    case "UNRECOGNIZED":
    default:
      return JurisdictionType.UNRECOGNIZED;
  }
}

export function jurisdictionTypeToJSON(object: JurisdictionType): string {
  switch (object) {
    case JurisdictionType.GLOBAL:
      return "GLOBAL";
    case JurisdictionType.WHO_REGION:
      return "WHO_REGION";
    case JurisdictionType.COUNTRY:
      return "COUNTRY";
    default:
      return "UNKNOWN";
  }
}

export enum Platform {
  IOS = 0,
  ANDROID = 1,
  WEB = 2,
  UNRECOGNIZED = -1,
}

export function platformFromJSON(object: any): Platform {
  switch (object) {
    case 0:
    case "IOS":
      return Platform.IOS;
    case 1:
    case "ANDROID":
      return Platform.ANDROID;
    case 2:
    case "WEB":
      return Platform.WEB;
    case -1:
    case "UNRECOGNIZED":
    default:
      return Platform.UNRECOGNIZED;
  }
}

export function platformToJSON(object: Platform): string {
  switch (object) {
    case Platform.IOS:
      return "IOS";
    case Platform.ANDROID:
      return "ANDROID";
    case Platform.WEB:
      return "WEB";
    default:
      return "UNKNOWN";
  }
}

export interface Void {}

export interface PutClientSettingsRequest {
  /** Firebase Cloud messaging registration token */
  token: string;
  /** User's selected location, ISO 3166-1 alpha-2 (uppercase) code. */
  isoCountryCode: string;
}

export interface JurisdictionId {
  jurisdictionType: JurisdictionType;
  /**
   * - Global: empty
   * - Country: ISO 3166-1 alpha-2 (uppercase) code
   * - Region: Any of the WHO_ prefixed region codes at https://apps.who.int/gho/data/node.metadata.REGION?lang=en
   */
  code: string;
}

export interface GetCaseStatsRequest {
  /** Request any jurisdictions (including global, if desired) */
  jurisdictions: JurisdictionId[];
}

export interface GetCaseStatsResponse {
  /** @deprecated */
  globalStats: CaseStats | undefined;
  /**
   * Provided in the same order as the requested jurisdictions.
   * If data in a jurisdiction is unavailable, lastUpdated will be 0.
   */
  jurisdictionStats: CaseStats[];
  /** Clients should not re-request stats until at least ttl seconds. */
  ttl: number;
}

export interface StatSnapshot {
  epochMsec: number;
  dailyCases: number;
  dailyDeaths: number;
  dailyRecoveries: number;
  totalCases: number;
  totalDeaths: number;
  totalRecoveries: number;
}

/** Statistics in a single or aggregate jurisdiction. */
export interface CaseStats {
  jurisdictionType: JurisdictionType;
  /** empty for global stats */
  jurisdiction: string;
  /** msec since epoch, or 0 if no data available. */
  lastUpdated: number;
  cases: number;
  deaths: number;
  recoveries: number;
  attribution: string;
  timeseries: StatSnapshot[];
}
