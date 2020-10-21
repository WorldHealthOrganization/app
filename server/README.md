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

## First Time Setup

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
