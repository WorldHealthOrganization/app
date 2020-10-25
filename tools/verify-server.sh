#!/bin/sh
set -euv
cd $(dirname "$0")/../server

# Server Checks
./gradlew test

# Terraform Checks
cd ./terraform
terraform validate .
terraform fmt -check -recursive .
