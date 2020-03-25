# Building the App for App Store Submission

First, clone the repo (requires `git` - see [Dependencies](#dependencies)):

```
git clone https://github.com/WorldHealthOrganization/app.git
cd app
```

## iOS

Adapting instructions from [Flutter's iOS deployment docs](https://flutter.dev/docs/deployment/ios).

These instructions assume that an app record has already been added to the App Store Connect account. If you haven't done so already, you can follow [these instructions](https://help.apple.com/app-store-connect/#/dev2cd126805).

### Install Dependencies

`cd` into the `client/flutter/ios` directory:

```
cd client/flutter/ios
```

Install CocoaPods dependencies (requires `CocoaPods` - see [Dependencies](#dependencies)):

```
pod install
```

Open the Xcode Workspace:

```
open Runner.xcworkspace
```

### Review Xcode Build Settings

For detailed procedures and descriptions, see [Prepare for app distribution](https://help.apple.com/xcode/mac/current/#/dev91fe7130a).

In Xcode:

1. Select **Runner** in the Xcode project navigator, then select the **Runner** target in the settings view sidebar.
1. Select the General tab.
1. Do not change the **Display Name** from `Runner`
1. Verify you have chosen the same **Bundle Identifier** as the app you have registered on App Store Connect.
1. In the **Signing** section, ensure `Automatically manage signing` is selected, and select the team associated with your Apple Developer account. If other ways of signing code are needed, review the [Code Signing Guide](https://developer.apple.com/library/archive/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html) and [Create, export, and delete signing certificates](https://help.apple.com/xcode/mac/current/#/dev154b28f09)

### Create a Build Archive

Configure the app version and build:

1. Select **Product > Scheme > Runner**.
1. Select **Product > Destination > Generic iOS Device**.
1. Select **Runner** in the Xcode project navigator, then select the **Runner** target in the settings view sidebar.
1. In the Identity section, update the **Version** number to the user-facing version number you wish to publish. For the initial App Store submission, version number should be `0.1.0`.
1. In the Identity section, update the **Build** identifier to a unique build number used to track this build on App Store Connect. Each upload requires a unique build number.

Create a build archive and upload it to App Store Connect:

1. Select **Product > Archive** to produce a build archive.
1. In the sidebar of the Xcode Organizer window, select your iOS app, then select the build archive you just produced.
1. Click the **Validate App** button. If any issues are reported, address them and produce another build. You can reuse the same build ID until you upload an archive.
1. After the archive has been successfully validated, click **Distribute App**. You can follow the status of your build in the Activities tab of your app’s details page on App Store Connect.

You should receive an email within 30 minutes notifying you that your build has been validated.

### Submit For Review

Go to the app's application details page on App Store Connect, and follow these steps:

1. Select Pricing and Availability from the sidebar of your app’s application details page on App Store Connect and complete the required information.
  * **_TODO: fill in details for how to not publish_**
1. Select the status from the sidebar. If this is the first release of this app, its status is 1.0 Prepare for Submission. Complete all required fields.
  * Assets prepared for submission: https://drive.google.com/drive/folders/17wi6q3Vlpt9KB6FuEOpZBdCJHtLCSXzh?usp=sharing
1. Click **Submit for Review**.

## Android

Adapting instructions from [Flutter's Android deployment docs](https://flutter.dev/docs/deployment/android)

### Signing the App

#### Create a Keystore

If you have an existing keystore, skip to the next step. If not, create one by running the following at the command line:

On Mac/Linux, use the following command:

```
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

On Windows, use the following command:

```
keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

_Warning: Keep the keystore file private; do not check it into public source control._

_Note: `keytool` is part of Java and requires Java to be part of your path_

#### Reference the keystore from the app

Create a file named `key.properties` in the `client/flutter/android` directory that contains a reference to your keystore:

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=key
storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
```

_Warning: Keep the key.properties file private; do not check it into public source control._

#### Configure signing in gradle

Configure signing for your app by editing the `build.gradle` file in the `client/flutter/android/app` directory.

1. Add code before android block:

```
   android {
      ...
   }
```

With the keystore information from your properties file:

```
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
         ...
   }
```

Load the `key.properties` file into the `keystoreProperties` object.

2. Add code before buildTypes block:

```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```

With the signing configuration info:

```
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```

Configure the `signingConfigs` block in your module’s `build.gradle` file.

Release builds of your app will now be signed automatically.

### Reviewing the app manifest

Review the default [App Manifest](https://developer.android.com/guide/topics/manifest/manifest-intro) file, `AndroidManifest.xml`, located in `client/flutter/android/app/src/main` and verify that the values are correct, especially the following:

`application`

Edit the `android:label` in the application tag to reflect the final name of the app.

### Reviewing the build configuration

Review the default [Gradle build file](https://developer.android.com/studio/build/#module-level) file, `build.gradle`, located in `client/flutter/android/app` and verify the values are correct, especially the following values in the `defaultConfig` block:

`applicationId`

Specify the final, unique (Application Id)appid

`versionCode` & `versionName`

Specify the internal app version number, and the version number display string. You can do this by setting the version property in the pubspec.yaml file. Consult the version information guidance in the [versions documentation](https://developer.android.com/studio/publish/versioning).

### Building the app for release

These instructions use the App Bundle release format instead of the APK format.

#### Build an app bundle

`cd` into the `client/flutter` directory:

```
cd .. # this assumes you're in the client/flutter/ios directory, if you're in the app directory you'll want to cd client/flutter
```

Build the app bundle with flutter:

```
flutter build appbundle
```

The release bundle for your app is created at `client/flutter/build/app/outputs/bundle/release/app.aab`.

### Upload the bundle to Google Play

This adapts instructions found [here](https://support.google.com/googleplay/android-developer/answer/7159011).

#### Create a release

A release is a combination of one or more build artifacts that you'll prepare to roll out an app or app update.

To start your release:

1. Go to your [Play Console](https://play.google.com/apps/publish/).
2. Select an app.
3. On the left menu, select **Release management > App releases**.
4. Next to the release type you want to create, select **Manage**, then select **Closed**.
5. To create a new release, select **Create release**.

#### Prepare your app's release

1. Follow the on-screen instructions to add APKs or app bundles, describe what's new in this release, and name your release. Use the APK generated in [Create a release](#create-a-release).
2. To save any changes you make to your release, select Save.
3. When you've finished preparing your release, select Review.

#### Review and roll out

Prerequisite: Before you can roll out your release, make sure you've completed your app's store listing, content rating, & pricing & distribution sections. When each section is complete, you'll see a green check mark next to it on the left menu.

Assets prepared for submission: https://drive.google.com/drive/folders/17wi6q3Vlpt9KB6FuEOpZBdCJHtLCSXzh?usp=sharing

1. Go to your Play Console.
2. Select an app.
3. On the left menu, select **Release management > App releases**.
4. Next to the release you want to roll out, select **Edit release**.
5. Review your draft release and make any additional changes that are needed.
6. Select **Review**. You'll be taken to the "Review and roll out release" screen, where you can make sure there aren't any issues with your release before rolling out to users.
7. Review any warnings or errors.
8. Select **Confirm rollout**.

## Dependencies

* [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation) (for building iOS)
* [Flutter](https://flutter.dev/docs/get-started/install) (for building Android)
