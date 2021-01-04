#!/bin/sh

set -ev
cd $(dirname "$0")

# Usage: ./tools/build-and-push-static-serving.sh <ProjectID>
# When running as a GitHub action, building and pushing are separated.

if [ "$DONT_BUILD" != "true" ]; then
  rm -rf staticContentBuild
  npm run prepare-static-serving
fi

if [ "$DONT_PUSH" != "true" ]; then
  PROJECT_ID=$1
  if ! [[ $PROJECT_ID == who-* ]]; then
    echo "Required argument: project id starting with 'who-' : $PROJECT"
    exit 1
  fi

  BUCKET=$PROJECT_ID-static-content
  set -euv
  gsutil -m -h "Cache-Control:public, max-age=600" -h "x-goog-meta-git-sha:$(git rev-parse HEAD)" -h "Content-Type:application/x-yaml;charset=utf-8" rsync -r ./staticContentBuild/ gs://$BUCKET/content/bundles/
fi
