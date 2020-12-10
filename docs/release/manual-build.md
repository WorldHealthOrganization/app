# Building the App for App Store Submission

_Note these instructions are for manual submission to the app stores, not for building the app during development. For the latter, see [here](../ONBOARDING.md)._

These instructions will assume that you have the up-to-date.
You'll need a Mac system for doing iOS builds.

- [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio/index.html)
- [XCode](https://developer.apple.com/xcode/)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation)

## Verify your tool versions

Verify your tool versions by running and checking all of these values:

```sh
> flutter --version
Flutter 1.22.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision fba99f6cf9 (8 days ago) • 2020-09-14 15:32:52 -0700
Engine • revision d1bc06f032
Tools • Dart 2.10.1

> xcodebuild -version
Xcode 12.0
Build version 12A7209

> pod --version
1.10.0
```

## Clone the Repo

In order to ensure reproducibility, you will always build from a specified `TAG_NAME` (e.g. `v0.1.0`) and should not change bundle/application ids or version or build numbers that are stored in the git repository.

```
git clone -b $TAG_NAME https://github.com/WorldHealthOrganization/app.git
cd app
```

## iOS

These instructions assume that an app record has already been added to the App Store Connect account. If you haven't done so already, you can follow [these instructions](https://help.apple.com/app-store-connect/#/dev2cd126805).

### Install Flutter Dependencies

```
cd client
flutter pub get
cd ios
pod install
```

### Prepare for app distribution

Follow Apple's instructions on [preparing for app distribution](https://help.apple.com/xcode/mac/current/#/dev91fe7130a) and [code signing](https://developer.apple.com/library/archive/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html).

**_Note: make sure you do not change the Display Name in the Runner target; Display Name should remain `Runner`_**

### Create a Build Archive

Clean build and then build the Flutter release:

```
./tools/gen-client-buildinfo.sh
cd client

flutter clean

flutter build ios --release --flavor prod
```

The release archive is located here:

```
client/build/ios/iphoneos/Runner.app
```

Follow Apple's instructions to:

1. [Create Archive](https://help.apple.com/xcode/mac/current/#/devf37a1db04)
1. [Validate the App](https://help.apple.com/xcode/mac/current/#/dev37441e273)
1. [App Store Connect Upload](https://help.apple.com/xcode/mac/current/#/dev442d7f2ca)

You should receive an email within 30 minutes notifying you that your build has been validated.

### Production vs Development Push Settings

In file Runner.entitlements change 'aps-environment' to either 'development' or 'production'
to select either the Sandbox or Production Apple Push Notification Service.

### Submit For Review

Follow Apple's instructions to [publish the app](https://help.apple.com/app-store-connect/#/dev34e9bbb5a). We have prepared the [assets needed for submission](https://drive.google.com/drive/folders/17wi6q3Vlpt9KB6FuEOpZBdCJHtLCSXzh?usp=sharing).

**WARNING:** In step 4 of [Submit your App for Review](https://help.apple.com/app-store-connect/#/dev301cb2b3e), choose the "Manually release this version" (release your app manually) option in the "Version Release" section to prevent inadvertent public distribution.

## Android

### Signing the App

Follow Flutter's [instructions for signing the app](https://flutter.dev/docs/deployment/android#signing-the-app). We strongly suggest using [app signing by Google Play](https://support.google.com/googleplay/android-developer/answer/7384423?hl=en).

### Building the app for release

Build the app bundle:

```
./tools/gen-client-buildinfo.sh
cd client
flutter build appbundle --release --flavor prod
```

The release bundle for your app is created at:

```
build/app/outputs/bundle/prodRelease/app-prod-release.aab
```

### Upload the bundle to Google Play

Follow Google's instructions to [prepare & roll out releases](https://support.google.com/googleplay/android-developer/answer/7159011).

**WARNING:** You must set the release type you want to create to "Closed" or you will inadvertently distribute the app to the general public.

We have prepared the [assets needed for submission](https://drive.google.com/drive/folders/17wi6q3Vlpt9KB6FuEOpZBdCJHtLCSXzh?usp=sharing).
