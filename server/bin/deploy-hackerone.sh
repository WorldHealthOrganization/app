#!/bin/sh

set -e
cd $(dirname "$0")/..

gradle build
gcloud beta app deploy --quiet --project=who-myhealth-hackerone appengine/build/war
