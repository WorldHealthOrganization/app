# who_app

## Getting Started

NOTE: We use Flutter SDK version `1.x.x`, NOT version `2.x.x`!

Install the latest `v1.x.x` Flutter release by downloading it [here](https://flutter.dev/docs/development/tools/sdk/releases) and then following the installation instructions [here](https://flutter.dev/docs/get-started/install).

Clone the repo, then...

### Set up Android Studio project

- Open Android Studio and select "Open Project".
- Select `app/client/app`. Wait a moment while Gradle syncs; this sync will **fail**.
- Open `local.properties` and add entries like the following:

```
flutter.sdk=/path/to/your/flutter
flutter.versionCode=1
flutter.versionName=0.0.1
```

- Run `File -> Sync Project with Gradle Files` to re-sync; this sync will succeed.
- Start your Android Virtual Device (AVD): `Tools` -> `AVD Manager` -> (on listed device) `Actions` -> `Run`.

You can now run the app by running:

```
cd client
flutter run --flavor staging
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

##### Using the Firebase Emulators

If you'd like to test your app without using a "real" Firebase project, you can use the Firebase Local Emulator Suite as follows.

First, start your local emulators by navigating to your `server/functions` directory and running:

    firebase emulators:start --project=dev

Then, in your `client` directory, update your `main.dart` as follows:

    const USE_FIREBASE_LOCAL_EMULATORS = true;

When working with the iOS client, temporarily disable transport security [as documented here](https://firebase.flutter.dev/docs/installation/ios/#enabling-use-of-firebase-emulator-suite).

Then, run your application in its `hack` flavor:

    flutter run --flavor=hack

Your logs will confirm that you are using the local emulators:

    I/flutter (13491): Will use local 🔥🔥 Firebase 🔥🔥 emulator
