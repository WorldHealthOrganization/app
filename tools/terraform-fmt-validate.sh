#!/bin/sh
# Run by .linstagedrc.json
# Ignores parameters of staged files to fmt and validate everything

set -euv
cd $(dirname "$0")/../server/terraform

terraform fmt -recursive .
terraform validate .
