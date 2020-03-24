# Product Roadmap

MAJOR CAVEAT: This is a WORK IN PROGRESS with many items TBD. We will want weigh-in from key folks across all areas, but the idea is that this is a living, breathing document that will grow over time.

### Summary

There is an urgent, global need for an official WHO App to help contain and mitigate COVID-19. The app should support the WHO efforts and be available on a worldwide basis, with information tailored to the user’s location, culture and language. The app should also be sensitive to national needs and respect privacy. Once established, the system can be leveraged to proactively detect, respond early and prevent future pandemics.

## Milestones

Version numbering terminology:

* **v0.1**: refers to the initial buildout that will be submitted to the app stores, aiming for Tuesday, March 24, 2020 ([v0.1 milestone](https://github.com/WorldHealthOrganization/app/milestone/2))
* **v0.2+**: any versions starting with major version v0 are not intended for public distribution or consumption
* **v1.0**: the first version that we feel offers enough value to be published onto the app stores for public download will be v1.0

### v0.1

**Goal:** To get a functional build of an application that can be submitted to the Apple App Store and Google Play Store for approval. This app will _NOT_ be published into those app stores for public download, but will instead serve as an approved base for future versions and to prove out that we can deliver on the technical side. The app will serve static content manually adapted from the WHO's site in English.

**Target Date:** Tuesday, March 24, 2020

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/2

Technical Features / Requirements:

* App built to be submitted on Apple App Store and Google Play Store, including code signing process
* UI styled to exact [design spec in Figma](https://www.figma.com/file/fjzTIloCEK4FpbyDiTLj2X/iOS-UX) ([#186](https://github.com/WorldHealthOrganization/app/issues/186))
  * Displaying static content in English only
* App is still functional in an offline environment with default content able to be accessed without a network connection ([#120](https://github.com/WorldHealthOrganization/app/pull/120) :white_check_mark:)
* Demonstrate capability to localize content from the technical platform perspective, even if other languages/cultures are _NOT_ part of that v0.1 launch
  * Framework in place to localize UI elements ([#126](https://github.com/WorldHealthOrganization/app/pull/126) :white_check_mark:)
  * Framework in place to load the informational content in localized formats ([#120](https://github.com/WorldHealthOrganization/app/pull/120) :white_check_mark:)
* Demonstrate capability to load content dynamically from the cloud, even if this feature will _NOT_ be turned on as part of the v0.1 launch ([#120](https://github.com/WorldHealthOrganization/app/pull/120) :white_check_mark:)
* _(Open Question)_ Demonstrate capability to instrument the app and collect basic analytics around which features and pages are actually being used, even if this feature will _NOT_ be turned on as part of the v0.1 launch ([#183](https://github.com/WorldHealthOrganization/app/issues/183))
  * Investigating legal requirements of this data collection, including whether updated TOS/Privacy Policy is needed

Features _NOT_ included in v0.1:

* Localization of initial content across languages/cultures outside of English / US
  * Blockers: translation & adaptation of content to enough other languages/cultures to be a meaningful initial feature
  * We are building in the capabilities into v0.1 from the technical perspective
* Triage survey telling users whether or not they should go to the hospital
  * Blockers: full definition on what the survey entails + legal review on the implications of making medical suggestions
  * _Question:_ do we want to link to an existing triage survey in a webview for v0.1, and if so, which one?

Non-Technical Requirements for v0.1:

* All content & assets required for submission to Apple App Store and Google Play Store ([#188](https://github.com/WorldHealthOrganization/app/issues/188), [#187](https://github.com/WorldHealthOrganization/app/issues/187) :warning:)
* Confirmed informational content & organization of that content included in app ([#93](https://github.com/WorldHealthOrganization/app/issues/93) :warning:)
* Any legal requirements for submission to app stores & legal review ([#17](https://github.com/WorldHealthOrganization/app/issues/17) :warning:)
* Account information/access from WHO to submit app on behalf of their accounts (also needed for code signing) ([#20](https://github.com/WorldHealthOrganization/app/issues/20) :warning:)

Other notes on v0.1:

* We have chosen to use Ionic React to get to a launchable prototype for v0.1. However, we are _NOT_ committed to using that in the longer term, and we have ongoing conversations about what the right frameworks to use will be (investigating Flutter and React Native)

### v0.2+

This section is a major WORK IN PROGRESS and is not fully complete. Listing out very initial thoughts for now.

**Goal:** Iterate on initial app submission with the goal of matching or exceeding the existing functionality in the WHO WhatsApp Bot presented idiomatically as an app. The app content should be localized to the 6 official WHO languages, with the ability to be served from the cloud.

**Target Date:** _(ongoing)_

Features:

* Process & pipeline for beta distribution of the app before public availability on app stores (e.g. TestFlight) ([#132](https://github.com/WorldHealthOrganization/app/issues/132))
  * _Possible v0.1 feature?_
* Possibly remodel the presentation of content using a Snapchat story-style interface
* Match or exceed the existing functionality & content in the WHO WhatsApp Bot, presented idiomatically as an app ([#208](https://github.com/WorldHealthOrganization/app/issues/208))
  * _See internal documentation on content in the bot_
* Dynamically loading data from the cloud for updates on content ([#120](https://github.com/WorldHealthOrganization/app/pull/120) :white_check_mark:)
  * Should still fall back to default data baked into app bundle for full functionality in an offline environment
* App content is available in the 6 official WHO languages: Arabic, Chinese, English, French, Russian, and Spanish ([#224](https://github.com/WorldHealthOrganization/app/issues/224))
  * Possibly further localized based on country
* Basic app instrumentation and analytics turned on in the app ([#183](https://github.com/WorldHealthOrganization/app/issues/183))
  * Complying with all applicable laws & regulations and app policies
  * Should be able to get basic analytics for product improvement, such as which features and pages are being used by end users
* Basic triage survey?

### v1.0

**Goal:** First fully-public app available for download

Lots of ongoing thoughts & conversations - we will update here when there are more concrete thoughts.
