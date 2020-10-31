#!/bin/sh
set -euv
cd $(dirname "$0")/../server

# Server Checks
./gradlew test

# Terraform Checks
cd ./terraform
# init is needed on CI
terraform init
terraform validate .
terraform fmt -check -recursive .
