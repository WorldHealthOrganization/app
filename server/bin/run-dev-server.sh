#!/bin/sh

set -e
cd $(dirname "$0")/..

gradle build

/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/java_dev_appserver.sh \
  --address=0.0.0.0 \
  --jvm_flag=-Duser.timezone=America/Los_Angeles \
  --jvm_flag=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
  appengine/build/war/