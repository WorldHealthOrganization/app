#!/bin/sh
set -euv

cd $(dirname "$0")/../server

# Server Checks
./gradlew test
