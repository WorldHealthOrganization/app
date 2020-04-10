#!/bin/sh

set -e
cd $(dirname "$0")/..

gradle build
gcloud beta app deploy --quiet --project=who-myhealth-production appengine/build/war
gcloud beta app deploy --quiet --project=who-myhealth-production appengine/build/war/WEB-INF/cron.yaml
