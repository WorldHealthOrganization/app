# Test Plan

## Introduction

This is the test plan for the WHO COVID-19 App and server.

Release Milestone - v1.0:  
[https://github.com/WorldHealthOrganization/app/milestone/4](https://github.com/WorldHealthOrganization/app/milestone/4)

## Automated Tests

We plan to use [Firebase Test Lab](https://firebase.google.com/docs/test-lab/android/overview) for as much test functionality as possible. That's for integration tests using Espresso binding for Flutter and Firebase Robo test crawler. We may also use others cloud device labs as support in performing various test types.

## Manual tests

Basic principle is to focus the manual testing on what would improve the broadest number of users that are using the app. In particular this involves testing on older, low powered devices, slow or no internet connection and small screen sizes.

### Minimum Requirements

It's important for the app to support as wide a userbase as possible. That means supporting a wide variety of operating systems, devices, particularly older and lower powered Android devices that are common in low and middle income countries.

These are the oldest OSs and some example devices that the app should support:

| OS                                 | Release Date  | Notes                                                  |
| ---------------------------------- | ------------- | ------------------------------------------------------ |
| **iOS 9.0**                        | Sept 16, 2015 | XCode 12 requires iOS 9.0,<br>Flutter supports iOS 8.0 |
| **Android 4.4<br>KitKat (API 19)** | Oct 31, 2013  | Flutter 1.22 requirement                               |

| Example Device                                                                  |      OS | Release Date |    Screen |      RAM | Note                |
| ------------------------------------------------------------------------------- | ------: | -----------: | --------: | -------: | ------------------- |
| [iPhone 4s](https://en.wikipedia.org/wiki/IPhone_4S)                            | iOS 9.0 | Oct 14, 2011 | 960 x 640 |   512 MB |                     |
| [Samsung Galaxy SII](https://en.wikipedia.org/wiki/Samsung_Galaxy_S_II)         |  API 19 |  May 2, 2011 | 800 x 480 | 1,000 MB |                     |
| [Karbonn Alfa A110](https://www.gadgetsnow.com/mobile-phones/Karbonn-Alfa-A110) |  API 19 |  Aug 3, 2015 | 480 x 320 | 256 MB\* | India value phone   |
| [Tecno H3](https://parktelonline.com/blog/tecno-h3-price-review-nigeria/        |  API 19 | Oct 27, 2014 | 320 x 480 |   512 MB | Nigeria value phone |

[*] Doesn't meet Android CDD requirement of 512 MB but we must serve as many devices as possible

### Scope

Manual testing should cover all parts of the user interface:

- Visit every page (external website links should be correct but are otherwise out of scope)
- Toggle all settings

### Display

- The app scales all user interface elements according to current screen density and size
- User interface elements do not overlap
- Usability or touch issues do not occur
- There is no problematic shrinkage of images because of high DPI/PPI

### Permissions

- App responds correctly if permission, rejected, withdrawn or re-enabled
- Android Permissions:
  - Notifications
- iOS Permissions:
  - Background App Refresh (fetch data and process)
  - Notifications
- Permission never requested for:
  - Bluetooth
  - Camera
  - File access
  - GPS Precise Location ([Privacy Policy](https://www.who.int/myhealthapp/privacy-notice) allows IP geolocation for approximate location)
  - Microphone
  - Photos

### Compatibility with Device Software

#### Sending, receiving and opening app notifications;

- The correct handling of notifications received when the app is in the foreground or background, especially under low battery conditions.

### User Preferences

- Settings are remembered between app and device restart but not across multiple devices
- Changing setting changes the app behaviour

### Internet Connectivity

- No internet => report to user that app is offline
- Slow internet => report to user if app functionality is limited
- Cellular vs. wifi connectivity switching

### Installation

- Intuitive install process
- Uninstall
- Re-installation should not restore any user data

### Screen Overlays

Various system overlays made by manufacturers:

- Samsung TouchWiz
- Samsung OneUI
- Huawei EMUI
- HTC Sense
- LG UX
- Google Pixel UI
- Sony Xperia UI

### Accessibility: Visual

- High contrast colours
- Black and white screen colours
- Minimum color contrast ratios of 3:1 for 18pt text and larger and 4.5:1 of any smaller text
- Touch targets are at least 44pt on iOS and 48dp on Android (in the smallest dimension)
- All interactive elements are labeled as such with accessibility traits that reflect interactive state and text labels

### Accessibility: Audio

Support for VoiceOver / TalkBack systems:

- Images provide text descriptions
- Screens MUST have meaningful titles
- Reading order of a screen MUST be logical and intuitive
- When content is added or deleted from a screen MUST be managed logically and never be lost
- Fonts should be resizable without breaking layout

### Risks

Unknown userbase is our main risk. We need to assume that they could use anything ranging from Samsung Galaxy Nexus \(Android 4.X\) and iPhone 4s \(iOS 9.3.5\) to Samsung Galaxy Folder 2 \(3.8" screen\), Samsung Galaxy View SM-760 \(18.4" screen\) and Infinix Zero 5 Pro \(with Mediatek MT6757CD Helio P20 CPU\) ending with Xiaomi Redmi K30 Pro \(2020 release\).
