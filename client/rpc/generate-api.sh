#!/bin/sh
# Generates Javascript stubs for our API

cd $(dirname "$0")/..

# TODO: Update output directory
java -jar lib/present-rpc-compiler.jar --proto_path=../proto --js_out=react/src
