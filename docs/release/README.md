# Release process

---

Items that are still under discussion / not ready to be used for v1.0 currently are marked with the :construction: icon.

:construction: Server-side aspects of the release process

## Checkoffs

### Product checks

1. [ ] Fidelity checks with mockups (design) \*
1. [ ] :construction: user testing ([discussion](https://github.com/WorldHealthOrganization/app/issues/243))
1. [ ] Go / No-go on individual features (engineering)
1. [ ] Create [release tag and release notes](https://github.com/WorldHealthOrganization/app/releases) for the newest release (engineering, [discussion](https://github.com/WorldHealthOrganization/app/issues/279))
1. [ ] Ensure that [all automated tests](https://github.com/WorldHealthOrganization/app/actions) pass for the given release tag (engineering)
1. [ ] :construction: QA and LQA (Localization Quality Assurance) tests

\* Sometimes, engineering slightly changes the mockups for ease of implementation/scalability or runs into unforeseen issues on various devices, etc. — issues not generally caught by unit and integration tests. A release preview (whether URL or TestFlight release) should be provided to the design team with enough time to provide light feedback and discuss any implementation trade-offs. We imagine a few hours to be ideal for this, but more time is always welcome.

### Compliance checks

- Medical Review ([discussion](https://github.com/WorldHealthOrganization/app/issues/18))
- Legal Review ([discussion](https://github.com/WorldHealthOrganization/app/issues/17))
- Security Review ([discussion](https://github.com/WorldHealthOrganization/app/issues/16))
- WHO Asset Clearance ([discussion](https://github.com/WorldHealthOrganization/app/issues/97))

### Store material check ([details](release/store-asset-checks.md))

1. [ ] iOS text assets
1. [ ] Android text assets
1. [ ] iOS screenshots
1. [ ] Android screenshots

## Release processes

1. Increment version in [pubspec.yaml](https://github.com/WorldHealthOrganization/app/blob/master/client/pubspec.yaml#L11)
1. Tag release with notes using GitHub [new release](https://github.com/WorldHealthOrganization/app/releases/new)

## QA testing with Firebase App Distribution

We use Firebase App Distribution to distribute apps to testers before the app gets deployed onto the App Store / Play Store. We currently do this only for Android; we do not release code for iOS until the TestFlight phase.

1. [ ] Build the app on a local developer's computer. The app can be signed with a Debug certificate and can be built by running `flutter build apk`. Note that the version does not necessarily need to be incremented here.
1. [ ] Upload the release apk to Firebase App Distribution. Make sure it is shared with "internal-testers-app-team" and provide the following text in the release notes: "Not a demo -- this release is only meant for internal testing."
1. [ ] QA testers will fill out any issues they find on a Bug Bash form.
1. [ ] We will triage these issues as needed. If a serious issue is detected, fix the issue and restart the release process.

:construction: This process may soon be automated by [#1293](https://github.com/WorldHealthOrganization/app/pull/1293)

### Push to stores

1. [ ] Determine drop-dead time for:

   - Stopping code churn
   - Finalizing release in Github
   - Pushing build from GitHub to WHO
   - Alpha release planned date
   - Production release planned date

1. [ ] Get all [checkoffs](#checkoffs).
1. [ ] WHO will check out the code from GitHub at the specified release tag. They will **build and sign** the iOS / Android binaries using **their keys**. More information on the steps WHO should perform to create a manual build is found in [manual-build.md](manual-build.md).
1. [ ] iOS: WHO will upload build to TestFlight.
1. [ ] Android: WHO will upload build to the Play Store and create a new "Alpha" release.
1. [ ] Double check that WHO has uploaded and updated the text / image assets that we want.

## Release to production

1. [ ] Upload all assets needed to a Google Drive folder and share it with the WHO.
1. [ ] WHO will fill in store information and update screenshots from the Google Drive folder.
1. [ ] iOS: WHO will submit the build for app review and select "Manually release this version". WHO should manually release the new version.
1. [ ] WHO should promote the Play Store release to "Production".

## :construction: Post-release tasks

1. [ ] Marketing
1. [ ] Additional testing
