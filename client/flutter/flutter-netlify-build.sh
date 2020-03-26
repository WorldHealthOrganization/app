#!/bin/sh
FLUTTER_BRANCH=`grep channel: .metadata | sed 's/  channel: //g'`
FLUTTER_REVISION=`grep revision: .metadata | sed 's/  revision: //g'`

mkdir flutter
cd flutter
git init
git remote add origin https://github.com/flutter/flutter.git
git fetch --depth 1 origin $FLUTTER_REVISION
cd ..

flutter/bin/flutter config --enable-web
flutter/bin/flutter build web
