#!/bin/sh

set -ev
cd $(dirname "$0")

# Only argument is ProjectId or Bucket Name (deprecated)
# When running as a GitHub action, building and pushing are separated.

if [ "$DONT_BUILD" != "true" ]; then
  rm -rf staticContentBuild
  npm run prepare-static-serving
fi

if [ "$DONT_PUSH" != "true" ]; then
  BUCKET=$1
  if ! [[ $BUCKET == who-* ]]; then
    echo "Required argument: project id starting with 'who-' : $PROJECT"
    exit 1
  fi
  # TODO: remove once .github/workflows/static-content.yaml is updated
  if [[ $BUCKET == *static-content* ]]; then
    echo "Deprecated argument for bucket name: $BUCKET"
  else
    BUCKET=$BUCKET-static-content
  fi
  set -euv
  gsutil -m -h "Cache-Control:public, max-age=600" -h "x-goog-meta-git-sha:$(git rev-parse HEAD)" -h "Content-Type:application/x-yaml;charset=utf-8" rsync -r ./staticContentBuild/ gs://$BUCKET/content/bundles/
fi
