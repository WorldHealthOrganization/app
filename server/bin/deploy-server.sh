#!/bin/sh

set -euv
cd $(dirname "$0")/..

PROJECT=$1

../tools/verify-server.sh

./gradlew build
gcloud beta app --quiet --project=$PROJECT deploy appengine/build/war
gcloud beta app --quiet --project=$PROJECT deploy appengine/build/war/WEB-INF/cron.yaml

# Force everything through the load balancer for security
gcloud beta app --quiet --project=$PROJECT services update default \
  --ingress internal-and-cloud-load-balancing
