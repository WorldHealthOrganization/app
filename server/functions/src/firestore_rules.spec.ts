import * as firebase from "@firebase/rules-unit-testing";
import "mocha";

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
  it("Should not allow direct access anywhere", async () => {
    // Random location in the database.
    await firebase.assertFails(
      app
        .firestore()
        .collection("NonexistentCollection")
        .doc("nonexistent-doc")
        .get()
    );
    // The Client collection.
    await firebase.assertFails(
      app
        .firestore()
        .collection("Client")
        .doc("00000000-0000-0000-0000-000000000000")
        .get()
    );
    // Add tests for real-life collections and documents here as we add them to Firestore.
  });
});
