#!/bin/sh

set -ev
cd $(dirname "$0")

# When running as a GitHub action, building and pushing are separated.

if [ "$DONT_BUILD" != "true" ]
then
  rm -rf staticContentBuild
  npm run prepare-static-serving
fi

if [ "$DONT_PUSH" != "true" ]
then
  set -euv
  gsutil -m -h "Cache-Control:public, max-age=600" -h "x-goog-meta-git-sha:$(git rev-parse HEAD)" -h "Content-Type:application/x-yaml;charset=utf-8" rsync -r ./staticContentBuild/ gs://$GS_BUCKET/content/bundles/
fi
