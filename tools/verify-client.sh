#!/bin/sh
set -euv
cd ../client
flutter analyze --no-pub
flutter test --no-pub
