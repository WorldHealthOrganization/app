#!/bin/sh

set -euv
cd $(dirname "$0")

# TODO: Once client has moved to new bucket, stop pushing to old bucket.
# Old bucket name.
GS_BUCKET=who-myhealth-staging-static-content-01 ./build-and-push-static-serving.sh
# New bucket name.
GS_BUCKET=who-mh-staging-static-content ./build-and-push-static-serving.sh
