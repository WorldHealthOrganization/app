# Product Roadmap

MAJOR CAVEAT: This is a WORK IN PROGRESS with many items TBD. We will want weigh-in from key folks across all areas, but the idea is that this is a living, breathing document that will grow over time.

All deadlines are in Pacific (US West Coast) time.

## Milestones

Version numbering terminology:

* **v1.0**: public release on the app stores, aiming for handoff to WHO for app store submission on Monday, March 30, 2020 ([v1.0 milestone](https://github.com/WorldHealthOrganization/app/milestone/4))
* **vNext**: describes features considered for future releases, but not yet prioritized into a specific milestone ([vNext milestone](https://github.com/WorldHealthOrganization/app/milestone/3))

### v1.0

**Goal:** Match or exceed the existing content in the WHO WhatsApp Bot presented idiomatically with native look-and-feel, with dynamically-updatable content localized to at least one other language besides English and ability to deliver push notifications to users.

**Target Date:** Monday, March 30, 2020 - handoff of app to WHO team for app store submission by EOD PDT

**GitHub Milestone:** https://github.com/WorldHealthOrganization/app/milestone/4

#### Technical Features / Requirements

* Content parity with the [WHO WhatsApp Bot](https://api.whatsapp.com/send?phone=41225017615&text=hi&source=&data=) ([#381](https://github.com/WorldHealthOrganization/app/issues/381))
* Native look-and-feel, designed to present content on mobile screens ([#382](https://github.com/WorldHealthOrganization/app/issues/382))
* Localized content translated to at least one other language besides English ([#383](https://github.com/WorldHealthOrganization/app/issues/383))
* Offline functionality with default content baked into the app bundle ([#384](https://github.com/WorldHealthOrganization/app/issues/384))
* Dynamically updated content served from the cloud so users don't need to update the app to receive content updates ([#385](https://github.com/WorldHealthOrganization/app/issues/385))
* Localized push notification capabilities ([#387](https://github.com/WorldHealthOrganization/app/issues/387))
  * _(Needs Discussion)_ What are the localization requirements for v1.0? What level of granularity will we need in region (e.g. language, continent, country, city, etc)? How will the user choose their location(s) for push delivery?
* Instrumentation/analytics capabilities for understanding aggregated usage information to be used for product improvement, complying with all applicable laws & regulations and app policies ([#389](https://github.com/WorldHealthOrganization/app/issues/389))
* _(Needs Discussion)_ Distribution pipeline using [fastlane](https://fastlane.tools/) for integration with WHO's existing app distribution process ([#318](https://github.com/WorldHealthOrganization/app/issues/318))
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
