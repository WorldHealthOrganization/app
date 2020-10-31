#!/bin/sh
set -euv

cd $(dirname "$0")/../client

flutter analyze --no-pub
flutter test --no-pub
