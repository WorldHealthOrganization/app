#!/bin/bash
set -euv
cd $(dirname "$0")

# Build the new assets.
npm --prefix ../tools/ install
DONT_PUSH=true ../tools/build-and-push-static-serving.sh

# Put the assets into Firebase Hosting, at the /content/* URL.
rm -rf ./public/content
mkdir -p ./public/content/bundles
cp -R ../tools/staticContentBuild/* ./public/content/bundles
