# Product Roadmap

MAJOR CAVEAT: This is a WORK IN PROGRESS with many items TBD. We will want weigh-in from key folks across all areas, but the idea is that this is a living, breathing document that will grow over time.

All deadlines are in Pacific (US West Coast) time.

### Summary

There is an urgent, global need for an official WHO App to help contain and mitigate COVID-19. The app should support the WHO efforts and be available on a worldwide basis, with information tailored to the user’s location, culture and language. The app should also be sensitive to national needs and respect privacy. Once established, the system can be leveraged to proactively detect, respond early and prevent future pandemics.

## Milestones

Version numbering terminology:

* **v0.1**: refers to the initial buildout that will be submitted to the app stores but not intended for public release, aiming for submission on Thursday, March 26, 2020 ([v0.1 milestone](https://github.com/WorldHealthOrganization/app/milestone/2))
* **v0.2**: an informal preview build for WHO by end of day Friday, March 27, 2020.  This is not a separate milestone.
* **v1.0**: first public release, sent to WHO end of day Monday, March 30, 2020 ([v1.0 milestone](https://github.com/WorldHealthOrganization/app/milestone/4))

### v0.1

**Goal:** To uncover any issues with app approvals

**Target Date:** Thursday, March 26, 2020

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/2

Technical Features / Requirements:

* Submit app to Apple App Store and Google Play Store, including code signing process
* UI styled to exact [design spec in Figma](https://www.figma.com/file/fjzTIloCEK4FpbyDiTLj2X/iOS-UX) ([#186](https://github.com/WorldHealthOrganization/app/issues/186))
  * Displaying static content in English only
* Offline functionality: default content still available without a network connection ([#120](https://github.com/WorldHealthOrganization/app/pull/120))
* Localization technical frameworks for UI elements and informational content, demonstrating capabilities even if content is not adapted to languages/cultures in this milestone ([#284](https://github.com/WorldHealthOrganization/app/pull/284))

Features _NOT_ included in v0.1:

* Localization of initial content across languages/cultures outside of English / US
  * Blockers: translation & adaptation of content to enough other languages/cultures to be a meaningful initial feature
  * We are building in the capabilities into v0.1 from the technical perspective
* Triage survey telling users whether or not they should go to the hospital
  * Blockers: full definition on what the survey entails + legal review on the implications of making medical suggestions

Non-Technical Requirements for v0.1:

* Content & assets required for submission to Apple App Store and Google Play Store (Text: [#188](https://github.com/WorldHealthOrganization/app/issues/188), Images: [#187](https://github.com/WorldHealthOrganization/app/issues/187))
* Informational content & organization of that content included in app ([#93](https://github.com/WorldHealthOrganization/app/issues/93))
* Legal requirements for submission to app stores & legal review ([#17](https://github.com/WorldHealthOrganization/app/issues/17) :warning:)
  * Privacy Policy
  * License Agreement
* Account information/access from WHO to submit app on behalf of their accounts (also needed for code signing) ([#20](https://github.com/WorldHealthOrganization/app/issues/20) :warning:)

Other notes on v0.1:

* We switched to the Flutter client framework for 0.1, and going forward.

### v0.2

**Target Date:** March 27, 2020

**Goal:** v0.2 is not a separate milestone, it simply whatever is in the repo by EOD Friday for preview by the WHO.

### v1.0

**Target Date:** March 30, 2020

**Goal:** In one sentence: v1.0 is a native look-and-feel, dynamically-updatable “port” of the WhatsApp bot content on iOS/Android, with information able to be served specific to your country and language (with at least 2 languages actually implemented), and the ability to push notifications in the future.

### vNext backlogs

This section is a major WORK IN PROGRESS and is not fully complete. Listing out very initial thoughts for now.

**Goal:** Match or exceed the existing functionality in the WHO WhatsApp Bot presented idiomatically as an app. App content should be localized to the 6 official WHO languages, with the ability to be served from the cloud.

Lots of ongoing thoughts & conversations - we will update here when there are more concrete thoughts.

**Target Date:** _(ongoing)_

Features:

* Beta distribution setup for the app before public availability on app stores (e.g. TestFlight) ([#132](https://github.com/WorldHealthOrganization/app/issues/132))
  * _Possible v0.1 feature?_
* Possibly remodel the presentation of content using a Snapchat story-style interface ([#229](https://github.com/WorldHealthOrganization/app/issues/229))
* Match or exceed the existing functionality & content in the [WHO WhatsApp Bot](https://api.whatsapp.com/send?phone=41225017615&text=hi&source=&data=), presented idiomatically as an app ([#208](https://github.com/WorldHealthOrganization/app/issues/208))
  * _See internal documentation on content in the bot_
* Dynamically loading data from the cloud for updates on content ([#120](https://github.com/WorldHealthOrganization/app/pull/120))
  * Should still fall back to default data baked into app bundle for full functionality in an offline environment
* App content is available in the 6 official WHO languages: Arabic, Chinese, English, French, Russian, and Spanish ([#224](https://github.com/WorldHealthOrganization/app/issues/224))
  * Possibly further localized based on country
* Analytics and instrumentation enabled in the app ([#183](https://github.com/WorldHealthOrganization/app/issues/183))
  * Complying with all applicable laws & regulations and app policies
  * Should be able to get basic analytics for product improvement, such as which features and pages are being used by end users
* Basic triage survey?

