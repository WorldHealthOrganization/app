#!/bin/sh
set -euv
cd ../client/flutter
flutter analyze --no-pub
flutter test --no-pub
