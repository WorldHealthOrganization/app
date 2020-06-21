# Test Plan

## Introduction

The idea of this Test Plan is to communicate the test approach to team members.

As the team works with the product, they will define the needs for the vNext.

### Objectives

We are focusing on manual testing and automated checks.

App milestones for 1.0:  
[https://github.com/WorldHealthOrganization/app/milestone/4](https://github.com/WorldHealthOrganization/app/milestone/4)

### Application architecture

Application is built using Flutter framework. We need to have this in mind and choose appropriate tools and approach.

We're supporting Android and iOS mobile operating systems.

- IOS from 8 to 13
- Android from 4.1\(API 16\) to 10.0 \(API 29\);

## Plan

### Manual tests

#### Scope

In manual testing, we should focus on all user interface interactions:

- Protect yourself
- Your questions answered
- Individual questions
- News & press
- External links w/titles/brief text
- Travel advice
- Myth-busters
- Latest numbers

#### Examples of configurations to focus on;

- Android GO - Nokia 2.1
- Older devices such as Samsung Galaxy Nexus (on Android 4.1 - 4.X) and iPhone 4s (on iOS 8.X)
- Smaller screen devices - iPhone 5
- Big screen with smaller resolution - iPhone XR
- Devices with custom user interface - Huawei P10 Lite

#### Android devices

- Samsung Galaxy Nexus
- Samsung Galaxy A40
- Samsung Galaxy S20
- Samsung Galaxy S10
- Samsung Galaxy S9
- Samsung Galaxy S8
- Samsung Galaxy S7
- Xiaomi Redmi 4A
- Xiaomi Redmi 5
- Xiaomi Redmi Note 7
- Huawei P20 Lite
- Huawei P10 Lite
- Nokia 2.1
- HTC U11
- LG G6
- BQ Aquaris M5

#### iOS devices

- Apple iPhone 4s
- Apple iPhone 5
- Apple iPhone 6
- Apple iPhone 8
- Apple iPhone SE
- Apple iPhone XR
- Apple iPhone XS

### Automated checks

We plan to use [Firebase Test Lab](https://firebase.google.com/docs/test-lab/android/overview) for as much test functionality as possible.

That's for integration tests using Espresso binding for Flutter and Firebase Robo test crawler.

We will also use others cloud device labs as support in performing various test types.

### Compatibility with Device Hardware

#### Different screen sizes and resolutions;

- The app scales all user interface elements according to current screen density and size.
- User interface elements do not overlap.
- Usability or touch issues do not occur.
- There is no problematic shrinkage of images because of high DPI/PPI.

#### App permissions;

- The app can work with reduced permissions. It asks the user to grant these permissions and does not fail in an unexplained manner.
- Permissions are only requested for the resources which are relevant to the app’s functionality.
- The app functionality responds correctly if permission is withdrawn or rejected.

### Compatibility with Device Software

#### Sending, receiving and opening app notifications;

- The correct handling of notifications received when the app is in the foreground or background, especially under low battery conditions.

#### User Preferences

- Users can amend typical preference options such as sound, brightness, network, power save mode, date and time, time zone, languages, access type and notifications.
- The apps adhere to the set preferences by behaving accordingly.

#### Interoperability

- Various system overlays made by manufacturers
  - Samsung TouchWiz;
  - Samsung OneUI;
  - Huawei EMUI;
  - HTC Sense;
  - LG UX;
  - Google Pixel UI;
  - Sony Xperia UI;

### Various Connectivity Methods

#### Low/mid/high internet speed;

- How the app behaves without internet.
- How the app behaves with slow internet.
- Correct app functionality with different connectivity modes.
- Switching between modes does not cause any unexpected behaviour or data loss.
- Clear information is given to the user if the functionality is restricted due to limited or no network connection or if bandwidth is low. The message should state the limitations and their reasons.

### Test Types to perform

#### Installability testing

- Is the installation process easy to understand.
- Re-installation.
- Uninstall.

#### Stress testing

- Low disk space.
- High CPU-usage.
- Device with slow CPU.

#### Performance testing

- Check slow and older devices.

#### Usability testing

- Be self-explanatory and intuitive.
- Allow user mistakes.
- Be consistent in wording and behaviour.
- Make necessary information visible and reachable in each screen size and type.

#### Accessibility testing

- Check screen readers.
- Check high contrast colours.
- Check black and white screen colours.
- Minimum color contrast ratios of 3:1 for 18pt text and larger and 4.5:1 of any smaller text.
- Touch targets are at least 44pt on iOS and 48dp on Android (in the smallest dimension).
- All interactive elements are labeled as such with accessibility traits that reflect interactive state and text labels.
- Images provide text descriptions
- Screens MUST have meaningful titles.
- The reading order of a screen as conveyed by VoiceOver / TalkBack MUST be logical and intuitive.
- When content is added or deleted from a screen, VoiceOver / TalkBack focus MUST be managed logically and never be lost.
- Fonts should be resizable without breaking layout.

### Test procedures

#### Coverage

After performing tests fill Device Coverage Sheet, so we could estimate our Device/OS/Overlay coverage.

#### Bug bash

Bug bashes will have their procedure which will be sent to invited users.

### Risks

#### We don't exactly know what devices our users will use.

That's our main risk. We need to assume that they could use anything ranging from Samsung Galaxy Nexus \(Android 4.X\) and iPhone 4s \(iOS 9.3.5\) to Samsung Galaxy Folder 2 \(3.8" screen\), Samsung Galaxy View SM-760 \(18.4" screen\) and Infinix Zero 5 Pro \(with Mediatek MT6757CD Helio P20 CPU\) ending with Xiaomi Redmi K30 Pro \(2020 release\).

We must deal with multiple device types, OS versions, screen sizes, quality of display and many more.
