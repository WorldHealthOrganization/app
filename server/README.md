# Server

## Google Cloud Projects

**Organization:** [`whocoronavirus.org`](https://console.cloud.google.com/iam-admin/settings?organizationId=532343229286)

All production servers - such as `who-mh-prod` - are part of the WHO Google Cloud
organization and not the developer organization.

### [`who-mh-hack`](https://console.cloud.google.com/home/dashboard?project=who-mh-hack)

Domain: `hack.whocoronavirus.org`

### [`who-mh-prod`](https://console.cloud.google.com/home/dashboard?project=who-mh-prod)

Domain: `covid19app.who.int`

### [`who-mh-staging`](https://console.cloud.google.com/home/dashboard?project=who-mh-staging)

Domain: `staging.whocoronavirus.org`

### [`who-mh2-dev1`(https://console.cloud.google.com/home/dashboard?project=who-mh2-dev1)

Domain: none yet.

## v2 backends (not ready yet)

The v2 backend is based on Firebase.

### Architecture

#### Firebase

We use many of Firebase's services, including Firestore, Cloud Functions, and Hosting, to serve the backend.

There are two standard Firebase configuration files checked in to the repo:

- A firebase.json [configuration file](https://firebase.google.com/docs/cli#the_firebasejson_file) that lists our project configuration.
- firebase.json - project [configuration file](https://firebase.google.com/docs/cli#the_firebasejson_file)
- `.firebaserc` - project [aliases](https://firebase.google.com/docs/cli#project_aliases)

#### Database

We use Firestore in Native mode. It has the following top-level collections:

| Collection | Document contents |
| ---------- | ----------------- |
| Client     | Client settings   |

Where possible, we access the database directly (using Firestore's own APIs) rather than write our own APIs. Firebase's Security Rules determine the permitted access. Our security rules are defined in `app/server/firestore.rules`.

#### Static Content

Static content is hosted by Firebase Hosting. Everything in the `app/server/public` folder is hosted. Most notable is the `content` folder; the contents of that folder are automatically produced at deploy-time.

Static content will be available via a URL like `https://OUR-PROJECT-ID.web.app` as well as any of our custom domains that we attach to the project (e.g. `example.whocoronavirus.org`).

#### Dynamic content, HTTPS APIs, server-side code

Dynamic content, HTTPS-based APIs, and any other server-side code are hosted on Cloud Functions. There are two kinds of Cloud Functions:

- HTTPS functions are reachable via a URL like `https://europe-west6-OUR-PROJECT-ID.cloudfunctions.net/getCaseStats`.
- Firestore-triggered functions respond to events in the database, they can't be called directly.

Our Cloud Functions code is in `app/server/functions/src`.

Using a custom domain to invoke HTTPS functions isn't possible for us yet, since we run outside of `us-central1`, where Firebase Hosting Rewrites [aren't supported yet](https://github.com/firebase/firebase-tools/issues/842). However, the hostname of our API should be a detail that's invisible to our users and therefore unimportant.

### Development and testing

To test your Firebase code (security rules, Cloud Functions) in a local environment, we use Firebase's [Emulator Suite](https://firebase.google.com/docs/emulator-suite).

To manually experiment with the emulator suite, run the following from the `functions` directory:

    npm run serve

To experiment with the HTTPS endpoints you can use the [Postman](https://www.postman.com/product/api-client/) collection of requests in `app/server/WHO.postman_collection.json`.

Our unit tests (`app/server/functions/**_spec.ts`) should be the main source of truth however; they use the emulators under the hood.

To run our unit tests, run the following from the `server` directory:

    npm run test

### Deploying

#### Initial setup

When setting up a new project, follow the instructions in [terraform/README.md](terraform/README.md) to...

- Obtain Terraform credentials.
- Create the project resources you'll be working with.

Make sure to also take the steps listed in [Manual Setup](terraform/README.md#manual-setup) that create the Firebase resources.

#### To update existing projects

To update the whole project to the latest version, from the `app/server` folder, run:

    firebase deploy --project=YOUR-PROJECT-ID

If you only want to update static assets, run:

    firebase deploy --project=YOUR-PROJECT-ID --only hosting

You should always specify a `--project=YOUR-PROJECT-ID`. If you'd like you can
use one a [project alias](https://firebase.google.com/docs/cli#project_aliases) instead of a project ID.

### Using the v2 backend

Currently, the v2 backend isn't ready for use by the client.

## v1 (deprecated)

### Curl Testing

#### App Engine:

```
# App Engine
curl -i \
	-H 'Content-Type: application/json' \
	-H 'Who-Client-ID: 00000000-0000-0000-0000-000000000000' \
	-H 'Who-Platform: WEB' \
	-X POST \
	-d '{token: 'test', isoCountryCode: CH}' \
	'https://staging.whocoronavirus.org/WhoService/putClientSettings'
```

#### Static Content

Served from Google Cloud Storage:

```
curl https://staging.whocoronavirus.org/content/bundles/protect_yourself.en_US.yaml

curl https://covid19app.who.int/content/bundles/protect_yourself.en_US.yaml
```

### Building and Deploying

**Note:** The deployment scripts run the build automatically.

All commands run from the server folder:

    cd server

#### Build Only

    gradle build

#### Local Development Server

    ./bin/run-dev-server.sh

Then open [http://localhost:8080/]().

#### Gcloud Auth

Either login with the service account or your personal account:

    # personal account
    gcloud auth

Service Account:

    # service account
    gcloud auth activate-service-account --key-file xxxx.json

#### Deploy

Deployment is organized by ProjectId.

##### Server

    ./bin/deploy-server.sh who-mh-staging

Then open [https://staging.whocoronavirus.org/app]() for a redirect to the app store.

##### Static Content

Deployed automatically on push to master by [.github/workflows/static-content.yaml](.github/workflows/static-content.yaml)
(NOTE: old staging server). Or pushed manually with (new staging server):

    ./tools/build-and-push-static-serving.sh who-mh-staging

## Dev Environment

### Install Homebrew

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### Install Java

Note: We run on Java 12 but target Java 8.

    brew tap adoptopenjdk/openjdk
    brew cask install adoptopenjdk12

### Install Gradle

    brew install gradle

### Install Google Cloud SDK

Follow the directions [here](https://cloud.google.com/sdk/docs/install?hl=en_US).

### Log In

    gcloud auth login

And, if you want to be able to manipulate Firebase:

    gcloud auth application-default login

### Install the most up-to-date App Engine Component

    gcloud components install beta app-engine-java && gcloud components update

### Install Terraform

Follow the directions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started)

### Install IntelliJ IDE (Optional)

    brew cask install intellij-idea-ce

Open the project in IntelliJ:

    open -a /Applications/IntelliJ\ IDEA\ CE.app/ .

### Install the Firebase CLI

Install the Firebase Command-Line Interface by following the instructions [here](https://firebase.google.com/docs/cli#install_the_firebase_cli).
