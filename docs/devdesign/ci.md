# Continuous Integration

## App Deployment

### Execution

On every push to `master` that affects the client, an Android APK will be pushed to the Firebase App Distribution staging environment using the `client-distribute-staging` workflow. Firebase will invite all members of the `every-build` testing group to test each of these builds.

### Setup

1.  (First time) Create [a service account](https://console.cloud.google.com/iam-admin/serviceaccounts/details/104111540645440452578?project=who-myhealth-staging) on `who-myhealth-staging` GCP with `Firebase App Distribution Admin` role.
2.  Create a Key for that service account: Add Key -> Create New Key -> JSON. Save the JSON file locally as `key.json`.
3.  Generate a random passphrase. Store that passphrase as GitHub secret `FIREBASE_APPDEPLOY_STAGING_SVCACCT_PASSPHRASE`.
4.  Encrypt and encode the key using the generated passphrase:

        gpg --symmetric --cipher-algo AES256 --armor < key.json | base64

5.  Store the encrypted key as GitHub secret `FIREBASE_APPDEPLOY_STAGING_SVCACCT_JSON`.
6.  Delete the older key on the service account on GCP.

## Server Deployment

### Execution

On every push to `master` that affects the server, the server will be pushed to the staging App Engine environment using the `server-deploy-staging` workflow.

### Setup

1.  (First time) Create [a service account](https://console.cloud.google.com/iam-admin/serviceaccounts/details/104111540645440452578?project=who-myhealth-staging) on `who-myhealth-staging` GCP with the following role:
    `App Engine Deployer`,
    `App Engine Service Admin`,
    `Cloud Build Editor`,
    `Cloud Scheduler Admin`, and
    `Storage Object Admin`.
2.  Create a Key for that service account: Add Key -> Create New Key -> JSON. Save the JSON file locally as `key.json`.
3.  Generate a random passphrase. Store that passphrase as GitHub secret `APP_ENGINE_DEPLOY_STAGING_SVCACCT_PASSPHRASE`.
4.  Encrypt and encode the key using the generated passphrase:

        gpg --symmetric --cipher-algo AES256 --armor < key.json | base64

5.  Store the encrypted key as GitHub secret `APP_ENGINE_DEPLOY_STAGING_SVCACCT_JSON`.
6.  Delete the older key on the service account on GCP.
