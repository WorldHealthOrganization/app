# Product Roadmap

MAJOR CAVEAT: This is a WORK IN PROGRESS with many items TBD. We will want weigh-in from key folks across all areas, but the idea is that this is a living, breathing document that will grow over time.

All deadlines are in Pacific (US West Coast) time.

### Summary

There is an urgent, global need for an official WHO App to help contain and mitigate COVID-19. The app should support the WHO efforts and be available on a worldwide basis, with information tailored to the user’s location, culture and language. The app should also be sensitive to national needs and respect privacy. Once established, the system can be leveraged to proactively detect, respond early and prevent future pandemics.

## Milestones

Version numbering terminology:

* **v1.0**: public release on the app stores, aiming for submission to app stores on Monday, March 30, 2020 ([v1.0 milestone](https://github.com/WorldHealthOrganization/app/milestone/4))
* **vNext**: describes features considered for future releases, but not yet prioritized into a specific milestone ([vNext milestone](https://github.com/WorldHealthOrganization/app/milestone/3))

### v1.0

**Goal:** Match or exceed the existing content in the WHO WhatsApp Bot presented idiomatically with native look-and-feel, with dynamically-updatable content localized to at least one other language besides English and ability to deliver push notifications to users.

**Target Date:** Monday, March 30, 2020 - transmission of app to WHO team for app store submission by EOD PDT

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/4

#### Technical Features / Requirements

* Content parity with the [WHO WhatsApp Bot](https://api.whatsapp.com/send?phone=41225017615&text=hi&source=&data=)
* Native look-and-feel, designed to present content on mobile screens
* Localized content translated to at least one other language besides English
* Offline functionality with default content baked into the app bundle
* Dynamically updated content served from the cloud so users don't need to update the app to receive content updates
* Localized push notification capabilities
  * _(Needs Discussion)_ What are the localization requirements for v1.0? What level of granularity will we need in region (e.g. language, continent, country, city, etc)? How will the user choose their location(s) for push delivery?
* Instrumentation/analytics capabilities for understanding aggregated usage information to be used for product improvement, complying with all applicable laws & regulations and app policies
* _(Needs Discussion)_ Distribution pipeline using [fastlane](https://fastlane.tools/) for integration with WHO's existing app distribution process
* Full security review

#### Features NOT Included

* Triage survey advising users on actions to take based on their symptoms
  * Currently investigating options to integrate, including COVID Check
  * Ideally, this will be a fast follow-on
* Translation into wide variety of languages
  * Although we will shoot for as many of WHO's 6 official languages as possible, the requirement is only for English + one additional language
  * We will want to thoroughly vet any translations that we include in a public release
* Localization of content based on country
  * We may address this technically anyway based on our solution to content localization, but it is not a requirement for v1.0

#### Non-Technical Requirements

* Content spec finalized
* Design spec finalized
* Legal deliverables
  * Addendum to privacy policy for analytics
  * Legal review, including ToS/EULA if required
* Updated visual and text assets for app store listings

### vNext backlogs

This section is a major WORK IN PROGRESS and is not fully complete. Listing out very initial thoughts for now.

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/3

#### Fast Follow-Ons

Features that we will want in upcoming milestones quickly after v1.0 release:

* Triage survey integration

## Release Notes

### v0.1

**Goal:** To uncover any issues with app approvals

**Target Date:** Thursday, March 26, 2020

**Release Date:** Thursday, March 26, 2020

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/2

#### Technical Features / Requirements

* Submit app to Apple App Store and Google Play Store, including code signing process
* UI styled to exact [design spec in Figma](https://www.figma.com/file/fjzTIloCEK4FpbyDiTLj2X/iOS-UX) ([#186](https://github.com/WorldHealthOrganization/app/issues/186))
  * Displaying static content in English only
* Offline functionality: default content still available without a network connection ([#120](https://github.com/WorldHealthOrganization/app/pull/120))
* Localization technical frameworks for UI elements and informational content, demonstrating capabilities even if content is not adapted to languages/cultures in this milestone ([#284](https://github.com/WorldHealthOrganization/app/pull/284))

#### Features NOT Included

* Localization of initial content across languages/cultures outside of English / US
  * Blockers: translation & adaptation of content to enough other languages/cultures to be a meaningful initial feature
  * We are building in the capabilities into v0.1 from the technical perspective
* Triage survey telling users whether or not they should go to the hospital
  * Blockers: full definition on what the survey entails + legal review on the implications of making medical suggestions

#### Non-Technical Requirements

* Content & assets required for submission to Apple App Store and Google Play Store (Text: [#188](https://github.com/WorldHealthOrganization/app/issues/188), Images: [#187](https://github.com/WorldHealthOrganization/app/issues/187))
* Informational content & organization of that content included in app ([#93](https://github.com/WorldHealthOrganization/app/issues/93))
* Legal requirements for submission to app stores & legal review ([#17](https://github.com/WorldHealthOrganization/app/issues/17))
  * Privacy Policy

#### Other Notes

* We switched to the Flutter client framework for 0.1, and going forward.
