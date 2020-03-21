#!/bin/sh
# Generates Javascript stubs for our API

cd $(dirname "$0")/..

# Downloaded v0.1 from here: https://github.com/presentco/present-rpc/tree/master/java/compiler
# TODO: Update output directory
java -jar lib/present-rpc-compiler.jar --proto_path=../proto --js_out=react/src
