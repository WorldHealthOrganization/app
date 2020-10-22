#!/bin/sh

set -euv
cd $(dirname "$0")/..

PROJECT=$1

../tools/verify-server.sh

./gradlew build
gcloud beta app deploy --quiet --project=$PROJECT appengine/build/war
gcloud beta app deploy --quiet --project=$PROJECT appengine/build/war/WEB-INF/cron.yaml
