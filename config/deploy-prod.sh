# Copies production firebase configs to the right spot.
# Run this before cutting a release branch.
cp config/google-services.json client/flutter/android/app
cp config/GoogleService-Info.plist client/flutter/ios/Runner