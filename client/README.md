# who_app

## Getting Started

Follow flutter installation instructions [here](https://flutter.dev/docs/get-started/install).

Clone the repo then:

```
cd client
flutter run
```

### iOS

```
cd client
flutter pub get

cd ios
sudo gem install cocoapods   # if needed
pod install
open Runner.xcworkspace
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
