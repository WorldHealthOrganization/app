import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as fs from "fs";
import { SERVING_REGION } from "./config";

admin.initializeApp();
const db = admin.firestore();

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
