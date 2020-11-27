#!/bin/sh

set -euv
cd $(dirname "$0")

GS_BUCKET=who-myhealth-europe-static-content-01 ./build-and-push-static-serving.sh
