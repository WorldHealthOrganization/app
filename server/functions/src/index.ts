import axios from "axios";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as fs from "fs";
import { SERVING_REGION } from "./config";

admin.initializeApp();
const db = admin.firestore();

//const axios = require('axios').default;

const COUNTRY_CODE = /^[A-Z][A-Z]$/; // Literal regex for immediate compilation.

// FCM documentation doesn"t specify standard but usually up to 162 chars
// https://stackoverflow.com/a/12502351/1509221
const FCM_TOKEN_MAX_LENGTH = 4096;

enum Platform {
  IOS = 0,
  ANDROID = 1,
  WEB = 2,
}

interface Client {
  uuid: string;
  token: string;
  disableNotifcations: boolean;
  platform: Platform;
  isoCountryCode: string;
  subscribedTopics: string[];
}

interface StoredStatSnapshot {
  epochMsec: number;

  dailyCases: number;
  dailyDeaths: number;
  dailyRecoveries: number;

  totalCases: number;
  totalDeaths: number;
  totalRecoveries: number;
}

// Note: This is defined in who.proto. Should we use that? Or get rid of this enum entirely?
enum JurisdictionType {
  GLOBAL = 0,
  WHO_REGION = 1,
  COUNTRY = 2,
}

interface StoredCaseStats {
  jurisdictionType: JurisdictionType;
  jurisdiction: string;
  lastUpdated: number;
  cases: number;
  deaths: number;
  recoveries: number;
  attribution: string;
  timeseries: StoredStatSnapshot[]; // XYZZY: This is a map in the intermediate stage and an array in the stored stage. TODO: Pull out map and keep adjacent?
}

// Implementation of the v1 API"s `getCaseStats` method.
// TODO: replace with direct Firestore access from the client.
export const getCaseStats = functions
  .region(SERVING_REGION)
  .https.onRequest((request, response) => {
    // A "fake" of the v1 API: we're just going to return a static file that we
    // happen to have on disk.
    // TODO: replace this with actual statistics in Firestore.
    const data = JSON.parse(fs.readFileSync("casestats.json", "utf8"));
    response.status(200).json(data);
  });

const WHO_CASE_STATS_URL =
  "https://services.arcgis.com/5T5nSi527N4F7luB/ArcGIS/rest/services/COVID_19_Historic_cases_by_country_pt_v7_view/FeatureServer/0/query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=ISO_2_CODE%2Cdate_epicrv%2CNewCase%2CCumCase%2CNewDeath%2CCumDeath%2C+ADM0_NAME&returnGeometry=false&featureEncoding=esriDefault&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnQueryGeometry=false&returnDistinctValues=false&cacheHint=false&groupByFieldsForStatistics=&outStatistics=&having=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&orderByFields=date_epicrv&token=";
// WHO_CASE_STATS_URL = "http://localhost:8888/arcgisdataElided.txt";

function getSnapshot(data: StoredCaseStats, timestamp: number) {
  if (data.timeseries.length != 0) {
    let snapshot = data.timeseries[data.timeseries.length - 1];
    if (snapshot.epochMsec > timestamp) {
      // While the old Java based system accepted data in any
      // order, the input data so far is always in chronological order.
      throw new Error("Out-of-sequence input data");
    }
    if (snapshot.epochMsec == timestamp) {
      if (data.jurisdictionType != JurisdictionType.GLOBAL) {
        throw new Error("Saw same timestamp twice.");
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

  let snapshot = getSnapshot(data, timestamp);

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

interface Attributes {
  ISO_2_CODE: string;
  date_epicrv: number;
  NewCase: number;
  CumCase: number;
  NewDeath: number;
  CumDeath: number;
  ADM0_NAME: string;
}

function processWhoStats(
  features: { attributes: Attributes }[],
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

function processCaseStats(data: { features: { attributes: Attributes }[] }) {
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

  let features = data.features;

  console.log("0 GlobalData: " + globalData);
  console.log("0 CountryData: " + countryData);

  processWhoStats(features, countryData, globalData);
  //console.log("P GlobalData", globalData);

  return countryData.get("NG");

  //db.collection("StoredCaseStats").doc("0:").set(globalData);
  // iterate over every country and add it with jurisdictionType : data.
  // Or do it as a sub-collection... but why bother...
}

// Refresh case statistics from data published by WHO on ArcGIS.
// TODO: Secure so not just anyone can hit it.
// TODO: ??? Rename to be 'internal' somehow? Use 'background functions'.
export const refreshCaseStats = functions
  .region(SERVING_REGION)
  .https.onRequest((request, response) => {
    // TODO: Call server until data exhausted.
    axios
      .get(WHO_CASE_STATS_URL)
      .then(function (remoteResponse) {
        //console.log(remoteResponse.data);
        console.log(typeof remoteResponse.data);
        console.log(typeof remoteResponse.data.features);
        let ng = processCaseStats(remoteResponse.data);

        console.log(updateData); // DELETEME  -- queiting compiler while commeinting out unfinished code
        //response.status(200).send("OK"); // What should we return? Anything useful for debug?
        response.status(200).json(ng);
      })
      .catch(function (error) {
        // Note that this includes both conneciton errors and any processing error!
        console.log(error);
        response.status(500).send("Error"); // How to get the system to backoff/retry? What text to use?
      });
  });

// Implementation of the v1 API"s `putClientSettings` method.
// TODO: replace with direct Firestore acccess from the client.
export const putClientSettings = functions
  .region(SERVING_REGION)
  .https.onRequest((request, response) => {
    const whoClientId = request.header("Who-Client-ID");
    if (whoClientId === undefined || whoClientId == null) {
      response.status(400).send("Missing Who-Client-ID header");
      return;
    }
    const whoPlatform = request.header("Who-Platform");
    if (whoPlatform === undefined || whoPlatform == null) {
      response.status(400).send("Missing Who-Platform header");
      return;
    }
    let platform = Platform.WEB;
    if (whoPlatform == Platform[Platform.ANDROID]) {
      platform = Platform.ANDROID;
    } else if (whoPlatform == Platform[Platform.IOS]) {
      platform = Platform.IOS;
    }

    if (request.method != "POST") {
      response.status(400).send("Call must be POST request");
      return;
    }
    let isoCountryCode = request.body["isoCountryCode"];
    if (isoCountryCode === undefined || isoCountryCode == null) {
      isoCountryCode = "";
    } else if (
      // Don"t even run a regex on a very long string.
      isoCountryCode.length != 2 ||
      !isoCountryCode.match(COUNTRY_CODE)
    ) {
      response.status(400).send("Invalid isoCountryCode");
      return;
    }
    let fcmToken = request.body["token"];
    if (fcmToken === undefined || fcmToken == "null") {
      fcmToken = "";
    }
    if (fcmToken.length > FCM_TOKEN_MAX_LENGTH) {
      response.status(400).send("Invalid FCM Token");
      return;
    }
    const disableNotifications = fcmToken.length == 0;

    const client = {
      uuid: whoClientId,
      token: fcmToken,
      disableNotifcations: disableNotifications,
      platform: platform,
      isoCountryCode: isoCountryCode,
      subscribedTopics: [], // TODO: fill in.
    } as Client;

    // This update will trigger the `clientSettingsUpdated` method below,
    // which will actually register (or deregister) the client for notifications.
    db.collection("Clients").doc(whoClientId).set(client);

    response.status(200).send({});
  });

// Method that runs when client settings have been updated, and will make those
// updated settings take effect.
export const clientSettingsUpdated = functions
  .region(SERVING_REGION)
  .firestore.document("Clients/{client_id}")
  .onWrite((change, context) => {
    console.log(`Client settings updated for ${context.params["client_id"]}`);
    // Get the current document value.
    // If the document does not exist, it has been deleted.
    const newDoc = change.after.exists ? change.after.data() : null;
    // Get the previous document value (for update or delete).
    const oldDoc = change.before.data();

    // TODO: replace the following placeholder code with real implementation
    // that (de)registers the client for notifications, following the same
    // logic we find in v1's NotificationsManager.java.
    if (newDoc !== null && newDoc !== undefined) {
      console.log(`New doc: ${newDoc.id}`);
    }
    if (oldDoc !== null && oldDoc !== undefined) {
      console.log(`Old doc: ${oldDoc.id}`);
    }
  });
