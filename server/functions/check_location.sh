#!/bin/bash
#
# Checks that the region configured for Cloud Functions (in `functions/index.ts`) matches the
# region configured for the project being deployed to.

set -eu

# What is the region this project is currently actually using?
# The easiest place to find that region seems to be the default storage bucket created by Firebase.
location_line=$(gsutil ls -L -b gs://$GCLOUD_PROJECT.appspot.com | grep "Location constraint")
read -a location_line_split <<<"$location_line"                                 # Splits string by spaces (default $IFS).
project_region=$(echo "${location_line_split[2]}" | tr '[:upper:]' '[:lower:]') # Makes location lowercase.
echo "Project's region is $project_region"

# What is the region currently configured for our Cloud Functions?
cd src
configured_region=$(npx ts-node -e 'import { SERVING_REGION } from "./config"; console.log(SERVING_REGION);')
echo "Configured region for Cloud Functions is $configured_region"

if [ "$configured_region" != "$project_region" ]; then
  echo "Region mismatch; Cloud Functions is set to $configured_region, project is $project_region"
  exit 1
fi
echo "Regions match."
