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

#### App Engine:

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
```

#### Static Content

Served from Google Cloud Storage:

```
curl https://staging.whocoronavirus.org/content/bundles/protect_yourself.en_US.yaml

curl https://covid19app.who.int/content/bundles/protect_yourself.en_US.yaml
```

## Building and Deploying

**Note:** The deployment scripts run the build automatically.

All commands run from the server folder:

    cd server

### Build Only

    gradle build

### Local Development Server

    ./bin/run-dev-server.sh

Then open [http://localhost:8080/]().

### Gcloud Auth

Either login with the service account or your personal account:

    # personal account
    gcloud auth

Service Account:

    # service account
    gcloud auth activate-service-account --key-file xxxx.json

### Deploy

Deployment is organized by ProjectId.

#### Server

    ./bin/deploy-server.sh who-mh-staging

Then open [https://staging.whocoronavirus.org/app]() for a redirect to the app store.

#### Static Content

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
