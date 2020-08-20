#!/bin/sh

set -euv
cd $(dirname "$0")

GS_BUCKET=who-myhealth-staging-static-content-01 ./_deploy-static-serving.sh
