#!/bin/sh
set -euv
cd $(dirname "$0")/../server

# Server Checks
./gradlew test

# Terraform Checks
cd ./terraform
# init for CI, check but don't format
terraform init
terraform validate .
terraform fmt -check -recursive .
