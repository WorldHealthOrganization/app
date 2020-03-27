# Release Notes

## v0.1

**Goal:** To uncover any issues with app approvals

**Target Date:** Thursday, March 26, 2020

**Release Date:** Thursday, March 26, 2020

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/2

### Technical Features / Requirements

* Submit app to Apple App Store and Google Play Store, including code signing process
* UI styled to exact [design spec in Figma](https://www.figma.com/file/fjzTIloCEK4FpbyDiTLj2X/iOS-UX) ([#186](https://github.com/WorldHealthOrganization/app/issues/186))
  * Displaying static content in English only
* Offline functionality: default content still available without a network connection ([#120](https://github.com/WorldHealthOrganization/app/pull/120))
* Localization technical frameworks for UI elements and informational content, demonstrating capabilities even if content is not adapted to languages/cultures in this milestone ([#284](https://github.com/WorldHealthOrganization/app/pull/284))

### Features NOT Included

* Localization of initial content across languages/cultures outside of English / US
  * Blockers: translation & adaptation of content to enough other languages/cultures to be a meaningful initial feature
  * We are building in the capabilities into v0.1 from the technical perspective
* Triage survey telling users whether or not they should go to the hospital
  * Blockers: full definition on what the survey entails + legal review on the implications of making medical suggestions

### Non-Technical Requirements

* Content & assets required for submission to Apple App Store and Google Play Store (Text: [#188](https://github.com/WorldHealthOrganization/app/issues/188), Images: [#187](https://github.com/WorldHealthOrganization/app/issues/187))
* Informational content & organization of that content included in app ([#93](https://github.com/WorldHealthOrganization/app/issues/93))
* Legal requirements for submission to app stores & legal review ([#17](https://github.com/WorldHealthOrganization/app/issues/17))
  * Privacy Policy

### Other Notes

* We switched to the Flutter client framework for 0.1, and going forward.
