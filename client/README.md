# who_app

## Getting Started

Clone the repo. We recommend using the [GitHub Desktop App](https://desktop.github.com):

https://github.com/WorldHealthOrganization/app/

## Windows

Install Flutter: https://flutter.dev/docs/get-started/install/windows

```
cd client
flutter run
```

### iOS

```
# Dependencies
brew install flutter
sudo gem install cocoapods

# Client
cd client
flutter pub get
cd ios

if [ `uname -m` = "arm64" ]; then
  # Apple Silicon
  sudo arch -x86_64 gem install ffi
  arch -x86_64 pod install
else
  pod install
fi

# Xcode
open Runner.xcworkspace
```

To run the client:
```
cd client
flutter run
```

### Firebase

The client apps communicate with Firebase by using generated config files, see
[Terraform README.md](https://github.com/WorldHealthOrganization/app/blob/master/server/terraform/README.md#firebase-app-registration).
The files are generated per project, indicated by the appendix on the filename.
For example to access the `staging` server (the default), the files are:

```
Android: client/android/app/src/<flavor>/google-services.json
iOS:     client/ios/config/<flavor>/GoogleService-Info.plist
```
