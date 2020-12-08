#!/bin/sh

set -euv
cd $(dirname "$0")/..

PROJECT=$1

../tools/verify-server.sh

./gradlew build
gcloud beta app --quiet --project=$PROJECT deploy appengine/build/war
gcloud beta app --quiet --project=$PROJECT deploy appengine/build/war/WEB-INF/cron.yaml

# TODO: Force everything through the load balancer for security
# TODO: --ingest internal-and-cloud-load-balancing
# App Engine cron jobs currently fail when this is enabled
# https://github.com/WorldHealthOrganization/app/issues/1804
gcloud beta app --quiet --project=$PROJECT services update default \
  --ingress all
