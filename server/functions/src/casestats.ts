import axios from "axios";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { SERVING_REGION } from "./config";

// THis seems wrong to initializeApp both here and index.ts?
//admin.initializeApp();
//const db = admin.firestore();
// The following line causes the Firebase emulator to say:
//  "It appears your code is written in Typescript, which must be compiled before emulation."
//const db = admin.firestore();
// This crazy mess makes it work.

var db: admin.firestore.Firestore;
export function setDb(newDb: admin.firestore.Firestore) {
  db = newDb;
}




//const axios = require('axios').default;

// Datastore record structure for Case Stats Data time series.
interface StoredStatSnapshot {
  epochMsec: number;

  dailyCases: number;
  dailyDeaths: number;
  dailyRecoveries: number;

  totalCases: number;
  totalDeaths: number;
  totalRecoveries: number;
}

// Note: This is defined in who.proto. Should we use that? Or get rid of this enum entirely? Some parts of the old system use the text label name as well.
enum JurisdictionType {
  GLOBAL = 0,
  WHO_REGION = 1,
  COUNTRY = 2,
}

// Datastore record structure for Case Stats Data per jurisdiction.
interface StoredCaseStats {
  jurisdictionType: JurisdictionType;
  jurisdiction: string;
  lastUpdated: number;
  cases: number;
  deaths: number;
  recoveries: number;
  attribution: string;
  timeseries: StoredStatSnapshot[];
}

let WHO_CASE_STATS_URL =
  "https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/COVID_19_Historic_cases_by_country_pt_v7_view/FeatureServer/0/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=ISO_2_CODE%2Cdate_epicrv%2CNewCase%2CCumCase%2CNewDeath%2CCumDeath%2C+ADM0_NAME&returnGeometry=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&groupByFieldsForStatistics=&outStatistics=&having=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&orderByFields=date_epicrv&token=";
// WHO_CASE_STATS_URL = "http://localhost:8888/arcgisdataElided.txt";
//WHO_CASE_STATS_URL = "http://localhost:8000/arcgisdataElided.txt";
//WHO_CASE_STATS_URL = "http://localhost:8000/x.txt";

// Peek or push last entry from timeseries.
function getSnapshotForTimestamp(data: StoredCaseStats, timestamp: number) {
  if (data.timeseries.length != 0) {
    let snapshot = data.timeseries[data.timeseries.length - 1];
    if (snapshot.epochMsec > timestamp) {
      throw new Error(
        `Unsorted country data found at ${timestamp} for {data.jurisdictionType} {data.jurisdiction}.`
      );
    }
    if (snapshot.epochMsec == timestamp) {
      if (data.jurisdictionType != JurisdictionType.GLOBAL) {
        // For individual jurisdictions, we should NOT see the same timestamp
        // more than once.
        // Fail and hope that the next run of the cron job succeeds.
        // Note that when the bad results are doubled/trebled/etc, they have
        // also been missing data, so ignoring duplicates is not safe.
        throw new Error(
          `Duplicate country data found at ${timestamp} for {data.jurisdictionType} {data.jurisdiction}.`
        );
      }
      return snapshot;
    }
  }

  let snapshot = {
    epochMsec: timestamp,

    dailyCases: 0,
    dailyDeaths: 0,
    dailyRecoveries: -1,

    totalCases: 0,
    totalDeaths: 0,
    totalRecoveries: -1,
  } as StoredStatSnapshot;

  data.timeseries.push(snapshot);
  return snapshot;
}

function updateData(
  data: StoredCaseStats,
  timestamp: number,
  dailyDeaths: number,
  totalDeaths: number,
  dailyCases: number,
  totalCases: number
) {
  if (timestamp > data.lastUpdated) {
    data.lastUpdated = timestamp;
  }
  // Note that data.totalCases is a sum of dailyCases,
  // while snapshot.totalCases is simply copied from the input data.
  // The totalCases at the most recent snapshot should match
  // data.totalCases, but this system does not verify that.
  data.cases += dailyCases;
  data.deaths += dailyDeaths;

  let snapshot = getSnapshotForTimestamp(data, timestamp);

  snapshot.dailyCases += dailyCases;
  snapshot.dailyDeaths += dailyDeaths;
  snapshot.totalCases += totalCases;
  snapshot.totalDeaths += totalDeaths;
}

/**
 * Process the JSON data returned by the ArcGIS server.
 *
 * @param features        JSON features from ArcGIS server
 * @param countryData Accumulated data for each country.
 * @param globalData  Accumulated data, sum of all countries.
 */

// Description of the JSON data returned by the ArcGIS Server
interface Attributes {
  ISO_2_CODE: string;
  date_epicrv: number;
  NewCase: number;
  CumCase: number;
  NewDeath: number;
  CumDeath: number;
  ADM0_NAME: string;
}

interface Feature {
  attributes: Attributes;
}

// The ARCGISResponse contains far more than this, but all we need are the features.
interface ArcGISResponse {
  features: Feature[];
}

function processWhoStats(
  features: Feature[],
  countryData: Map<string, StoredCaseStats>,
  globalData: StoredCaseStats
) {
  for (let feature of features) {
    let attributes = feature.attributes;
    updateData(
      globalData,
      attributes.date_epicrv,
      attributes.NewDeath,
      attributes.CumDeath,
      attributes.NewCase,
      attributes.CumCase
    );

    let isoCode = attributes["ISO_2_CODE"];
    if (isoCode) {
      if (!countryData.has(isoCode)) {
        let data = {
          jurisdictionType: JurisdictionType.COUNTRY,
          jurisdiction: isoCode,
          lastUpdated: 0,
          cases: 0,
          deaths: 0,
          recoveries: 0,
          attribution: "WHO",
          timeseries: [],
        } as StoredCaseStats;

        countryData.set(isoCode, data);
      }

      updateData(
        countryData.get(isoCode)!,
        attributes.date_epicrv,
        attributes.NewDeath,
        attributes.CumDeath,
        attributes.NewCase,
        attributes.CumCase
      );
    }
  }
}

async function processCaseStats(baseUrl: string) {
  let countryData: Map<string, StoredCaseStats> = new Map<
    string,
    StoredCaseStats
  >();
  let globalData = {
    jurisdictionType: JurisdictionType.GLOBAL,
    jurisdiction: "",
    lastUpdated: 0,
    cases: 0,
    deaths: 0,
    recoveries: 0,
    attribution: "WHO",
    timeseries: [],
  } as StoredCaseStats;

  let offset = 0;
  let moreData = true;
  while (moreData) {
    let url = `${baseUrl}&resultOffset=${offset}`;
    console.log(`Fetching ${url}...`);
    await axios
      .get(url)
      .then(function (remoteResponse) {
        let data = remoteResponse.data as ArcGISResponse;
        let features = data.features;
        if (features == undefined || features.length == 0) {
          console.log(`No features found at ${url}.`);
          moreData = false;
        } else {
          offset += features.length;
          console.log(`Processing ${url} with ${features.length} features...`);
          processWhoStats(features, countryData, globalData);
        }
      })
      .catch(function (error) {
        moreData = false;
        console.log(error);
        throw new Error(`Failed HTTP request to ${url}.`);
        return;
      });
  }

  console.log(
    `Found ${countryData.size} countries and ${globalData.timeseries.length} time points.`
  );

  // add globalData to countryData since from now on it'll be similar...
  countryData.set("", globalData);
  return countryData;
}

/**
 * Correct partial last day
 *
 * CountryData last day dropped if likely "No Data Reported"
 * GlobalData totals to use all data, not sum of possible incomplete countries
 *
 * See https://github.com/WorldHealthOrganization/app/issues/1724
 */
function fixPartialLastDayAll(
  globalData: StoredCaseStats,
  countryData: Map<string, StoredCaseStats>
) {
  // Global last snapshot
  // Last day snapshot daily cases and deaths may remain as partial
  let snapshot = globalData.timeseries[globalData.timeseries.length - 1];
  snapshot.totalCases = globalData.cases;
  snapshot.totalDeaths = globalData.deaths;

  // ArcGIS data can distinguish between "Zero Cases" and "No Data Reported"
  // but appears to often report the former when it means the latter
  //
  // Heuristic:
  //   if lastDayNumbers > 0 => assume up to date
  //   if lastDayNumbers == 0 && priorDayNumbers > 0 => assume "No Data Reported" and delete
  let countriesLastDayRemoved = [];
  for (let [countryName, countryStat] of countryData) {
    let timeseries = countryStat.timeseries;
    if (timeseries.length < 2) {
      continue;
    }

    let lastSnapshot = timeseries[timeseries.length - 1];
    let priorSnapshot = timeseries[timeseries.length - 2];

    // Consider removing last day
    if (lastSnapshot.dailyCases == 0 && lastSnapshot.dailyDeaths == 0) {
      if (priorSnapshot.dailyCases > 0 || priorSnapshot.dailyDeaths > 0) {
        // Likely "No Data Reported"
        timeseries.pop();
        countryStat.lastUpdated = priorSnapshot.epochMsec;
        countriesLastDayRemoved.push(countryName);
      }
    }
  }
  console.log("Countries last day removed: " + countriesLastDayRemoved);
}

function caseStatsDocName(stat: StoredCaseStats) {
  // Datastore key name. E.g. '0:' (globaldata) or '2:US' (countryData).
  return `${stat.jurisdictionType}:${stat.jurisdiction}`;
}

// Save case stats after doing a bit of validation and cleanup.
async function saveCaseStats(
  globalData: StoredCaseStats,
  countryData: Map<string, StoredCaseStats>
) {
  fixPartialLastDayAll(globalData, countryData);

  // TODO: Implement this!
  /*
    // Reject unexpected changes in case stats, e.g. too large an increase
    CaseStats oldCaseStats = StoredCaseStats.load(JurisdictionType.GLOBAL, "");
    if (oldCaseStats != null) {
      totalCasesDeltaCheck(oldCaseStats.cases, globalData.totalCases);
    }
    */

  await db.collection("StoredCaseStats")
    .doc(caseStatsDocName(globalData))
    .set(globalData);

  for (let countryStat of countryData.values()) {
    await db.collection("StoredCaseStats")
      .doc(caseStatsDocName(countryStat))
      .set(countryStat);
  }
}

// Refresh case statistics from data published by WHO on ArcGIS.
// TODO: Secure so not just anyone can hit it.
// TODO: ??? Rename to be 'internal' somehow? Use 'background functions'.
export const refreshCaseStats = functions
  .region(SERVING_REGION)
  .https.onRequest((request, response) => {
    processCaseStats(WHO_CASE_STATS_URL)
      .then(function (countryData) {
        let globalData = countryData.get("");
        if (globalData == undefined) {
          // Should be impossible!
          response.status(500).send("Error");
          return;
        }
        countryData.delete("");
        saveCaseStats(globalData, countryData);

        response.status(200).send("OK");
      })
      .catch(function (error) {
        console.log(error);
        response.status(500).send("Error"); // How to get the system to backoff/retry? What text to use?
        return;
      });
  });

// TODO: How do we specify which region this should run in? This data is public,
// but we presumably want it to run in the same region as our datastore and
// other code.
// TODO: Scheduled functions require billing (lol). It's only $0.10/month but
// but that's absurd for a tiny project...
export const refreshCaseStatsScheduledFunction = functions.pubsub
  .schedule("every 5 minutes")
  .onRun((context) => {
    console.log("This will be run every 5 minutes!");
    return null;
  });
