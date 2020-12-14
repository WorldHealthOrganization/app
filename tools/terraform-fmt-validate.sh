#!/bin/bash
# Run by .linstagedrc.json
# Ignores parameters of staged files to fmt and validate everything
# Can pass -check flag to terraform fmt

set -euv

cd $(dirname "$0")/../server/terraform/

args=""
# More brittle than it should be
if ([ $# -eq 1 ] && [ $1 = "-check" ]); then
  args=$1
fi

projects=("hack" "prod" "prod-in-dev" "staging")
for project in "${projects[@]}"; do
  # quietens init but errors still go to stderr
  # https://github.com/hashicorp/terraform/issues/18467#issuecomment-405376611
  terraform init $project >/dev/null
  terraform fmt -recursive $args $project
  terraform validate $project
done
