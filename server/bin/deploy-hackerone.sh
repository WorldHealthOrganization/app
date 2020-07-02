#!/bin/sh

set -e
cd $(dirname "$0")/..

./gradlew build
gcloud beta app deploy --quiet --project=who-myhealth-hackerone appengine/build/war
gcloud beta app deploy --quiet --project=who-myhealth-hackerone appengine/build/war/WEB-INF/cron.yaml
