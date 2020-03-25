# Building the App for App Store Submission

These instructions will assume that you have the up-to-date [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Flutter](https://flutter.dev/docs/get-started/install), [Android Studio](https://developer.android.com/studio/index.html), [XCode](https://developer.apple.com/xcode/), and [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation) already installed.  You must use a macOS system to build the iOS app.
  * _Note: this was tested using CocoaPods version `1.9.1`_

## Clone the Repo

In order to ensure reproducibility, you will always build from a specified `TAG_NAME` (e.g. `v0.1.0`) and should not change bundle/application ids or version or build numbers that are stored in the git repository.

```
git clone -b TAG_NAME https://github.com/WorldHealthOrganization/app.git
cd app
```

## iOS

These instructions assume that an app record has already been added to the App Store Connect account. If you haven't done so already, you can follow [these instructions](https://help.apple.com/app-store-connect/#/dev2cd126805).

### Install Flutter Dependencies

```
cd $(git rev-parse --show-toplevel)/client/flutter
flutter pub get
cd ios
pod install
```

### Prepare for app distribution

Follow Apple's instructions on [preparing for app distribution](https://help.apple.com/xcode/mac/current/#/dev91fe7130a) and [code signing](https://developer.apple.com/library/archive/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html).

**_Note: make sure you do not change the Display Name in the Runner target; Display Name should remain `Runner`_**

### Create a Build Archive

Prepare the Flutter release:

```
cd $(git rev-parse --show-toplevel)/client/flutter
flutter build ios
```

_Note: if you are on Xcode version 8.2 or earlier, you will need to close and re-open Xcode to ensure that the release configuration mode is refreshed_

Follow Apple's instructions to [create an archive](https://help.apple.com/xcode/mac/current/#/devf37a1db04), [validate the app](https://help.apple.com/xcode/mac/current/#/dev37441e273), and [upload it to App Store Connect](https://help.apple.com/xcode/mac/current/#/dev442d7f2ca).

You should receive an email within 30 minutes notifying you that your build has been validated.

### Submit For Review

Follow Apple's instructions to [publish the app](https://help.apple.com/app-store-connect/#/dev34e9bbb5a). We have prepared the [assets needed for submission](https://drive.google.com/drive/folders/17wi6q3Vlpt9KB6FuEOpZBdCJHtLCSXzh?usp=sharing).

**WARNING:** In step 4, choose the  "Manually release this version" option in the "Version Release" section to prevent inadvertent public distribution.

## Android

### Signing the App

Follow Flutter's [instructions for signing the app](https://flutter.dev/docs/deployment/android#signing-the-app). We strongly suggest using [app signing by Google Play](https://support.google.com/googleplay/android-developer/answer/7384423?hl=en).

### Building the app for release

Build the app bundle:

```
cd $(git rev-parse --show-toplevel)/client/flutter
flutter build appbundle
```

The release bundle for your app is created at `client/flutter/build/app/outputs/bundle/release/app.aab`.

### Upload the bundle to Google Play

Follow Google's instructions to [prepare & roll out releases](https://support.google.com/googleplay/android-developer/answer/7159011).

**WARNING:** You must set the release type you want to create to "Closed" or you will inadvertently distribute the app to the general public.

We have prepared the [assets needed for submission](https://drive.google.com/drive/folders/17wi6q3Vlpt9KB6FuEOpZBdCJHtLCSXzh?usp=sharing).
