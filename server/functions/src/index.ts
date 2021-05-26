import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { SERVING_REGION } from "./config";
import * as refreshcasestats from "./refreshcasestats"; // Is this right?
import * as who from "./who";

admin.initializeApp();
const db = admin.firestore();

const COUNTRY_CODE = /^[A-Z][A-Z]$/; // Literal regex for immediate compilation.

// FCM documentation doesn"t specify standard but usually up to 162 chars
// https://stackoverflow.com/a/12502351/1509221
const FCM_TOKEN_MAX_LENGTH = 4096;

interface Client {
  uuid: string;
  token: string;
  disableNotifcations: boolean;
  platform: who.Platform;
  isoCountryCode: string;
  subscribedTopics: string[];
}

refreshcasestats.setDb(db); /// This seems wrong???????????????????????????????????????????????????????????
export const refreshCaseStats = refreshcasestats.refreshCaseStats;

async function getCaseStatsAsync(req: who.GetCaseStatsRequest) {
  let jurisdictions = req.jurisdictions;
  if (jurisdictions == undefined) {
    throw Error("Bad request.");
  }
  let resp: who.GetCaseStatsResponse = {
    globalStats: undefined,
    jurisdictionStats: [],
    ttl: 0,
  };

  for (let jurisdiction of jurisdictions) {
    let key = `${who.jurisdictionTypeFromJSON(jurisdiction.jurisdictionType)}:${
      jurisdiction.code
    }`;
    console.log(`Loading data for ${key}`);
    let loadedData = await db
      .collection(refreshcasestats.CASE_STATS_COLLECTION)
      .doc(key)
      .get();
    let jurisdictionData = loadedData.data() as who.CaseStats;
    resp.jurisdictionStats.push(jurisdictionData);
  }

  return resp;
}

// Implementation of the v1 API"s `getCaseStats` method.
// TODO: replace with direct Firestore access from the client.
export const getCaseStats = functions
  .region(SERVING_REGION)
  .https.onRequest(async (request, response) => {
    try {
      let resp = await getCaseStatsAsync(request.body);

      response.status(200).json(resp);
    } catch (error) {
      console.log(error);
      response.status(400).send("Error"); // distinguish 400 and 500?
    }
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
    let platform = who.platformFromJSON(whoPlatform);

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
