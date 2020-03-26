#!/bin/sh
git clone https://github.com/flutter/flutter.git --depth 1 -b beta _flutter
_flutter/bin/flutter config --enable-web
_flutter/bin/flutter build web
rm -rf _flutter