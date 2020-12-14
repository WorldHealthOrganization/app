# Generate BuildInfo
#
# All data must be deterministic and repeatable for reproducible builds:
# https://github.com/WorldHealthOrganization/app/issues/1084

set -euv

git diff --exit-code

GIT_SHA="$(git rev-parse --verify HEAD)"

cat <<EOF >client/lib/generated/build.dart
class BuildInfo {
  static const POPULATED = true;
  static const GIT_SHA = "$GIT_SHA";
  static const FLUTTER_VERSION = '''$(flutter --version)''';
}
EOF

cat client/lib/generated/build.dart
