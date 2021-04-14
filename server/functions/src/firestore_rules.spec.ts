/**
 * This file contains unit tests for the Firestore Rules stored in
 * the `firestore.rules` file in the root `server` directory.
 *
 * Note that this file therefore isn't directly about Cloud Functions,
 * we just conveniently already have all the `node_modules` we need to
 * run the test installed here.
 *
 * These tests require that the Firebase emulators are running, and are
 * written and run using Mocha, e.g.:
 *   $ firebase --project=$GCLOUD_PROJECT emulators:exec "mocha -r ts-node/register src/firestore_rules.spec.ts"
 *
 * The easiest is to just run:
 *   $ npm run test
 */

// Instead of using the real `firebase` SDK, we'll use a fake `firebase`
// built specifically to unittest Firestore Rules.
import * as firebase from "@firebase/rules-unit-testing";

// Connect to the local Firestore emulator. The Firestore tooling sets
// the `GCLOUD_PROJECT` environment variable for us, so we know which
// project ID to connect to.
const projectId = process.env.GCLOUD_PROJECT;
if (projectId === undefined) {
  throw Error("Missing GCLOUD_PROJECT environment variable.");
}
const app = firebase.initializeTestApp({
  projectId: projectId,
  // No auth.
});

after(() => {
  // Clean up any/all database connections.
  Promise.all(firebase.apps().map((app) => app.delete()));
});

describe("Firebase Rules", () => {
  it("Should not allow access in random places", async () => {
    // Random location in the database.
    await firebase.assertFails(
      app
        .firestore()
        .collection("NonexistentCollection")
        .doc("nonexistent-doc")
        .get()
    );
  });
  it("Should only allow write access to the Client collection", async () => {
    await firebase.assertFails(
      app
        .firestore()
        .collection("Client")
        .doc("00000000-0000-0000-0000-000000000000")
        .get()
    );
    await firebase.assertSucceeds(
      app
        .firestore()
        .collection("Client")
        .doc("00000000-0000-0000-0000-000000000000")
        .set({
          foo: "bar",
        })
    );
  });
  // Add further tests for real-life collections and documents here as we add them to Firestore.
});
