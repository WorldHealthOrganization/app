# Release process
______
Items that are still under discussion / not ready to be used for v1.0 currently are marked with the :construction: icon.

:construction: Server-side aspects of the release process

## Checkoffs

### Product checks
1. [ ]  Fidelity checks with mockups (design) \*
1. [ ]  :construction: user testing ([discussion](https://github.com/WorldHealthOrganization/app/issues/243))
1. [ ]  Go / No-go on individual features (engineering)
1. [ ]  Create [release tag and release notes](https://github.com/WorldHealthOrganization/app/releases) for the newest release (engineering, [discussion](https://github.com/WorldHealthOrganization/app/issues/279))
1. [ ]  Ensure that [all automated tests](https://github.com/WorldHealthOrganization/app/actions) pass for the given release tag (engineering)
1. [ ]  :construction: QA and LQA (Localization Quality Assurance) tests


\* Sometimes, engineering slightly changes the mockups for ease of implementation/scalability or runs into unforeseen issues on various devices, etc. — issues not generally caught by unit and integration tests. A release preview (whether URL or TestFlight release) should be provided to the design team with enough time to provide light feedback and discuss any implementation trade-offs. We imagine a few hours to be ideal for this, but more time is always welcome.

### Compliance checks
- Medical Review ([discussion](https://github.com/WorldHealthOrganization/app/issues/18))
- Legal Review ([discussion](https://github.com/WorldHealthOrganization/app/issues/17))
- Security Review ([discussion](https://github.com/WorldHealthOrganization/app/issues/16))
- WHO Asset Clearance ([discussion](https://github.com/WorldHealthOrganization/app/issues/97))


### Store material check ([details](release/store_asset_checks.md))

1. [ ] iOS text assets
1. [ ] Android text assets
1. [ ] iOS screenshots
1. [ ] Android screenshots 

## Release processes

### Prepare to release

1. [ ] Create release Slack channel for updates and announcements
1. [ ] Create Google Drive folder to store text / image assets
1. [ ] Check build instructions for clarity and accuracy. :construction: wrap instructions in a single script
1. [ ] Determine the gatekeepers for the following categories (this may change as people join or leave)
   1. [ ] Engineering
   1. [ ] Design
   1. [ ] Compliance

### Push to stores

1. Determine drop-dead time for:
  - [ ] Stopping code churn
  - [ ] Finalizing release in Github
  - [ ] Pushing build from GitHub to WHO
  - [ ] Alpha release planned date
  - [ ] Production release planned date
1. [ ] Get all [checkoffs](#checkoffs)
1. [ ] Upload all assets needed to Google Drive and share it with the WHO
1. [ ] WHO will check out the code from GitHub at the specified release tag. They will **build and sign** the iOS / Android binaries using **their keys**.
1. [ ] WHO will fill in store information and update screenshots from the Google Drive folder.
1. [ ] iOS: WHO will upload build to TestFlight. They will also submit the build for app review and select "Manually release this version".
1. [ ] Android: WHO will upload build to the Play Store and create a new "Alpha" release.
1. [ ] Double check that WHO has uploaded and updated the text / image assets that we want.

## Alpha testing

Alpha testing lets you share the app with a known list of email addresses.

1. [ ] Recruit a small sample of < 25 users from Slack with a variety of different phone models.
1. [ ] Send these testing users' emails to the WHO so they can invite them for Alpha testing (Android) or TestFlight (iOS).
1. [ ] Ask them to perform basic testing, ensure that app does not crash or have serious problems.
1. [ ] If a serious issue is detected, fix the issue and restart the release process.

## Beta testing

Unlike Alpha testing, Beta testing lets you share a public link to invite testers.

1. [ ] WHO will promote the app to the "Beta" track on Google Play, and updates TestFlight Beta testing with the latest build.
1. [ ] Publish beta testing URLs for both Android and iOS to Slack.
1. [ ] Collect beta test feedback in a Google doc.

## :construction: Firebase App Distribution

We are looking to move our alpha / beta testing phase to Firebase App Distribution, because it allows us to publish versions of the app to testers without having to go through the app stores' approval processes or have production credentials to build development versions of the app. We will add documentation for this step once we have ironed out the process.

## Release to production

1. [ ] Once the App Store review approval has been granted, WHO should manually release the new version.
1. [ ] WHO should promote the Play Store release to "Production".

## :construction: Post-release tasks

1. [ ] Marketing
1. [ ] Additional testing
