set -euv

git diff --exit-code

GIT_SHA="$(git rev-parse --verify HEAD)"
BUILT_AT="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

cat <<EOF >client/lib/generated/build.dart
class BuildInfo {
  static const POPULATED = true;
  static const GIT_SHA = "$GIT_SHA";
  static const BUILT_AT = "$BUILT_AT";
  static const DEVELOPMENT_ONLY = $DEVELOPMENT_ONLY;
  static const FLUTTER_VERSION = '''$(flutter --version)''';
}
EOF

cat client/lib/generated/build.dart
