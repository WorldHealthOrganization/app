#!/bin/sh
FLUTTER_BRANCH=`grep channel: .metadata | sed 's/  channel: //g'`
FLUTTER_REVISION=`grep revision: .metadata | sed 's/  revision: //g'`

git clone https://github.com/flutter/flutter.git
cd flutter
git checkout $FLUTTER_BRANCH
git pull origin $FLUTTER_BRANCH
git checkout $FLUTTER_REVISION
cd ..

flutter/bin/flutter config --enable-web
flutter/bin/flutter build web