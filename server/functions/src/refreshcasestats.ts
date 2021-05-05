import axios from "axios";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { SERVING_REGION } from "./config";
import * as who from "./who";

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

// Triggers to reject case stats update for unexpectedly large increase
// Tuned to only trigger a handful of time in early pandemic and never since April 1st
// Largest Cases Stats increase was 15.2% on March 24th
// Triggers are cumulative rather than triggered separately
const TOTAL_CASES_MAX_DAILY_INCREASE_FACTOR = 1.05;
const TOTAL_CASES_MAX_DAILY_INCREASE_ABS = 30000;

let WHO_CASE_STATS_URL =
  "https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/COVID_19_Historic_cases_by_country_pt_v7_view/FeatureServer/0/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=ISO_2_CODE%2Cdate_epicrv%2CNewCase%2CCumCase%2CNewDeath%2CCumDeath%2C+ADM0_NAME&returnGeometry=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&groupByFieldsForStatistics=&outStatistics=&having=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&orderByFields=date_epicrv&token=";
//WHO_CASE_STATS_URL = "http://localhost:8000/arcgisdataElided.txt";
//WHO_CASE_STATS_URL = "http://localhost:8000/x.txt";

// Peek or push last entry from timeseries.
function getSnapshotForTimestamp(data: who.CaseStats, timestamp: number) {
  if (data.timeseries.length != 0) {
    let snapshot = data.timeseries[data.timeseries.length - 1];
    if (snapshot.epochMsec > timestamp) {
      throw new Error(
        `Unsorted country data found at ${timestamp} for {data.jurisdictionType} {data.jurisdiction}.`
      );
    }
    if (snapshot.epochMsec == timestamp) {
      if (data.jurisdictionType != who.JurisdictionType.GLOBAL) {
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
  } as who.StatSnapshot;

  data.timeseries.push(snapshot);
  return snapshot;
}

function updateData(
  data: who.CaseStats,
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

// The ARCGISResponse contains more than this, but all we need are the features.
interface ArcGISResponse {
  features: Feature[];
}

function processWhoStats(
  features: Feature[],
  countryData: Map<string, who.CaseStats>,
  globalData: who.CaseStats
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
          jurisdictionType: who.JurisdictionType.COUNTRY,
          jurisdiction: isoCode,
          lastUpdated: 0,
          cases: 0,
          deaths: 0,
          recoveries: 0,
          attribution: "WHO",
          timeseries: [],
        } as who.CaseStats;

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
  let countryData: Map<string, who.CaseStats> = new Map<
    string,
    who.CaseStats
  >();
  let globalData = {
    jurisdictionType: who.JurisdictionType.GLOBAL,
    jurisdiction: "",
    lastUpdated: 0,
    cases: 0,
    deaths: 0,
    recoveries: 0,
    attribution: "WHO",
    timeseries: [],
  } as who.CaseStats;

  let offset = 0;
  let moreData = true;
  while (moreData) {
    let url = `${baseUrl}&resultOffset=${offset}`;
    console.log(`Fetching ${url}...`);
    let remoteResponse = await axios.get(url);
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
  globalData: who.CaseStats,
  countryData: Map<string, who.CaseStats>
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

function totalCasesDeltaCheck(oldTotalCases: number, newTotalCases: number) {
  let thresholdTotalCases =
    oldTotalCases * TOTAL_CASES_MAX_DAILY_INCREASE_FACTOR +
    TOTAL_CASES_MAX_DAILY_INCREASE_ABS;
  if (newTotalCases > thresholdTotalCases || newTotalCases < oldTotalCases) {
    console.log(
      `Unexpected delta in global cases. Old total: ${oldTotalCases}, New total: ${newTotalCases}`
    );
    throw new Error("Unexpected delta in global cases.");
  }
}

function caseStatsDocName(stat: who.CaseStats) {
  // Datastore key name. E.g. '0:' (globalData) or '2:US' (countryData).
  return `${stat.jurisdictionType}:${stat.jurisdiction}`;
}

// Save case stats after doing a bit of validation and cleanup.
async function saveCaseStats(
  globalData: who.CaseStats,
  countryData: Map<string, who.CaseStats>
) {
  fixPartialLastDayAll(globalData, countryData);

  // Reject unexpected changes in case stats, e.g. too large an increase
  let loadedData = await db
    .collection("StoredCaseStats")
    .doc(caseStatsDocName(globalData))
    .get();
  if (loadedData != undefined) {
    let oldGlobalData = loadedData.data() as who.CaseStats;
    if (oldGlobalData != null) {
      totalCasesDeltaCheck(oldGlobalData.cases, globalData.cases);
    }
  }

  console.log("Storing to datastore...");

  await db
    .collection("StoredCaseStats")
    .doc(caseStatsDocName(globalData))
    .set(globalData);

  let promises = [];
  for (let countryStat of countryData.values()) {
    promises.push(
      db
        .collection("StoredCaseStats")
        .doc(caseStatsDocName(countryStat))
        .set(countryStat)
    );
  }
  console.log("Awaiting datastore... " + promises.length);
  await Promise.all(promises);
  console.log("Datastore set complete.");
}

async function refreshCaseStatsAsync() {
  let countryData = await processCaseStats(WHO_CASE_STATS_URL);
  let globalData = countryData.get("");
  if (globalData == undefined) {
    // Should be impossible!
    return false;
  }
  countryData.delete("");
  try {
    await saveCaseStats(globalData, countryData);
  } catch (Error) {
    console.log("Error saving case stats: " + Error.message);
    return false;
  }
  return true;
}

const runtimeOpts = {
  timeoutSeconds: 300,
};

// Refresh case statistics from data published by WHO on ArcGIS.
// TODO: Secure so not just anyone can hit it.
// TODO: ??? Rename to be 'internal' somehow? Use 'background functions'.
export const refreshCaseStats = functions
  .region(SERVING_REGION)
  .runWith(runtimeOpts)
  .https.onRequest((request, response) => {
    refreshCaseStatsAsync()
      .then(function (ok) {
        if (!ok) {
          response.status(500).send("Error");
          return;
        }
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
