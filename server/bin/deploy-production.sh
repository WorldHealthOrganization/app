#!/bin/sh

set -e
cd $(dirname "$0")/..

PROJECT=who-myhealth-europe

./gradlew build
gcloud beta app deploy --quiet --project=$PROJECT appengine/build/war
gcloud beta app deploy --quiet --project=$PROJECT appengine/build/war/WEB-INF/cron.yaml
