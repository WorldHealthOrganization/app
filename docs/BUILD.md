# Building the App for App Store Submission

First, clone the repo (requires `git` - see [Dependencies](#dependencies)):

```
git clone https://github.com/WorldHealthOrganization/app.git
cd app
```

## iOS

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



## Dependencies

* [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation) (for building iOS)
