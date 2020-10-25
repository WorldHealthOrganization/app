# Server

## Google Cloud Projects

**Organization:** [`whocoronavirus.org`](https://console.cloud.google.com/iam-admin/settings?organizationId=532343229286)

### [`who-myhealth-staging`](https://console.cloud.google.com/home/dashboard?project=who-myhealth-staging)

Domain: `staging.whocoronavirus.org`

Services:

- Staging App Engine
- Staging Cloud Datastore
- Staging Firebase Project

### [`who-myhealth-production`](https://console.cloud.google.com/home/dashboard?project=who-myhealth-production)

Services:

- Production Firebase Project

### [`who-myhealth-europe`](https://console.cloud.google.com/home/dashboard?project=who-myhealth-europe)

Domain: `whoapp.org`

Services:

- Production App Engine
- Production Cloud Datastore

## Curl Testing

Against staging:

```
# App Engine
curl -i \
	-H 'Content-Type: application/json' \
	-H 'Who-Client-ID: 00000000-0000-0000-0000-000000000000' \
	-H 'Who-Platform: WEB' \
	-X POST \
	-d '{token: 'test'}' \
	'https://whoapp.org/WhoService/putDeviceToken'

curl -i \
	-H 'Content-Type: application/json' \
	-H 'Who-Client-ID: 00000000-0000-0000-0000-000000000000' \
	-H 'Who-Platform: WEB' \
	-X POST \
	-d '{isoCountryCode: CH}' \
	'https://whoapp.org/WhoService/putLocation'

# Static Content - served from Google Cloud Storage
curl https://storage.googleapis.com/who-myhealth-staging-static-content-01/\
content/bundles/protect_yourself.en_US.yaml
```

## Building and Deploying

_Note:_ The deployment scripts run the build automatically.

### Build Only

    $ gradle build

### Run the Server Locally

    $ ./bin/run-dev-server.sh

Then open [http://localhost:8080/]().

### Deploy to Staging

    $ ./bin/deploy-staging.sh

Then open [https://who-app-staging.appspot.com/]().

### Deploy to Staging - Static Content

Deployed automatically on push to master by [.github/workflows/static-content.yaml](.github/workflows/static-content.yaml). Or pushed manually with:

    $ tools/deploy-staging-static-serving.sh

### Deploy to Production

    $ ./bin/deploy-production.sh

Then open [https://who-app.appspot.com/]().

## Dev Environment

### Install Homebrew

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### Install Java

Note: We run on Java 12 but target Java 8.

    $ brew tap adoptopenjdk/openjdk
    $ brew cask install adoptopenjdk12

### Install Gradle

    $ brew install gradle

### Install Google Cloud SDK

Follow the directions [here](https://cloud.google.com/sdk/docs/install?hl=en_US).

### Log In

    $ gcloud auth login

And, if you want to be able to manipulate Firebase:

    $ gcloud auth application-default login

### Install the most up-to-date App Engine Component

    $  gcloud components install beta app-engine-java && gcloud components update

### Install Terraform

Follow the directions [here](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started)

### Install IntelliJ IDE (Optional)

    $ brew cask install intellij-idea-ce

Open the project in IntelliJ:

    $ open -a /Applications/IntelliJ\ IDEA\ CE.app/ .

## Cloud Project Setup

This setup must be done manually for each project upon setup. The config should be moved to terraform if it can support this in the future.

### Firebase

1. [Firebase Console](https://console.firebase.google.com/u/0/project/who-myhealth-staging/analytics/overview)
1. "Analytics" => "Retention"
1. Click "Enable Google Analytics"
1. Create account with name that matches project, e.g. "who-myhealth-staging"
1. Analytics location => "Switzerland" (this doesn't limit where Firebase processes data)
1. Disable "Use the default settings..."
   - Disable all settings, except:
   - Production: "Technical support" may only be enabled temporarily with WHO permission
   - Non-Production: enable "Technical support"
1. Select "I accept the Google Analytics terms"

### Google Analytics

1. [Google Analytics Console](https://analytics.google.com/analytics/web/)
1. Select project, e.g. "who-myhealth-staging"
1. Data Settings
   1. Data Retention: "Event Data Retention" => 2 months
   1. "Reset user data on new activity" => off
1. Default Reporting Identity => select "By device only"

### Firebase App Registration

This provides the config files that the Android and iOS apps need to communicate with the Firebase instance.

#### Android

1. [Firebase Console](https://console.firebase.google.com/u/0/project/who-myhealth-staging/analytics/overview)
1. "Project Overview" at top left of console
1. "+ Add app" => "Android" (left most icon)
1. Android package name: "org.who.WHOMyHealth"
   - **NOTE:** Android and iOS IDs are different
1. App nickname: "WHO COVID-19"
1. Skip "Debug signing cert"... might be needed for staging apks
1. "Register app"
1. "Download google-services.json" and move to `<repo>/client/android/app/`
1. TODO: need mechanism to switch between Firebase instances
1. Skip "Add Firebase SDK" and "Add initialization code"
1. Run Android app in simulator to confirm Firebase setup

#### iOS

1. Repeat steps 1..3 above but select "iOS" (2nd icon on left)
1. iOS bundle ID: "int.who.WHOMyHealth"
   - **NOTE:** Android and iOS IDs are different
1. App nickname: "WHO COVID-19"
1. App Store ID: leave blank except for production
1. "Register app"
1. "Download GoogleService-Info.plist" and move to `<repo>/client/ios/Runner/`
1. TODO: need mechanism to switch between Firebase instances
1. Skip "Add Firebase SDK" and "Add initialization code"
1. Run iOS app in simulator to confirm Firebase setup
