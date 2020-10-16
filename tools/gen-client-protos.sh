set -euv

# You must do the following first:
# flutter pub global activate protoc_plugin ^19.0.1
# export PATH=$PATH:$FLUTTER_PATH/.pub-cache/bin

protoc --dart_out=./client/lib/proto/ api/who/who.proto
