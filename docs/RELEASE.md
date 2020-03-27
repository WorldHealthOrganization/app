# Release process and check offs (client only)
______
since there is no server component at this time

## Checkoffs

## Product checks
1. [ ]  fidelity checks with mockups (design) \*
1. [ ]  :construction: user testing (**[there is currently no plan for this](https://github.com/WorldHealthOrganization/app/issues/243)**)
1. [ ]  go/nogo on individual features (engineering)
1. [ ]  release tag created (or maybe release branch, [discussion](https://github.com/WorldHealthOrganization/app/issues/279))
1. [ ]  all automated tests pass
1. [ ]  LQA tests
1. [ ]  release notes generated

\* Sometimes, engineering slightly changes the mockups for ease of implementation/scalability or runs into unforeseen issues on various devices, etc. — issues not generally caught by unit and integration tests. A release preview (whether URL or TestFlight release) should be provided to the design team with enough time to provide light feedback and discuss any implementation trade-offs. We imagine a few hours to be ideal for this, but more time is always welcome.

## Compliance checks
### Security checks ([discussion](https://github.com/WorldHealthOrganization/app/issues/269), [details](release/security_check_details.md))
- [ ] System Boundary
- [ ] APIs and Interconnection (external systems and services)
- [ ] Infrastructure
- [ ] Data Flow
- [ ] Cryptography
### Privacy checks ([discussion](https://github.com/WorldHealthOrganization/app/issues/280))
Check how we stack up against these principles (qualitative evaluation, [details](release/privacy_check_details.md))
- [ ] Collection Limitation Principle
- [ ] Data Quality Principle
- [ ] Purpose Specification Principle
- [ ] Use Limitation Principle
- [ ] Security Safeguards Principle
- [ ] Openness Principle
- [ ] Individual Participation Principle
- [ ] Accountability Principle
### Legal checks ([discussion](https://github.com/WorldHealthOrganization/app/issues/17))
- [ ] 3rd party libraries / dependency license review
- [ ] CLA / developer license review
- [ ] Verify privacy policy vs actual system


## Store material check ([details](release/store_asset_checks.md))

1. [ ] iOS text assets committed
1. [ ] android text assets committed
1. [ ] iOS screenshots committed
1. [ ] android screenshots committed 

## Final WHO sign off/approval
:construction: [waiting for input](https://github.com/WorldHealthOrganization/app/issues/274) from @brunobowden

## Release processes

### Prepare to release

1. [ ] create release channel
1. [ ] create release tag/branch ([discussion](https://github.com/WorldHealthOrganization/app/issues/279))
1. [ ] :construction: create Google Drive to push release to WHO
1. [ ] check build instructions for clarity and accuracy. :construction: wrap instructions in a single script
1. [ ] determine the gatekeepers for the following categories (this may change as people join or leave)
   1. [ ] engineering
   1. [ ] design
   1. [ ] compliance

### Push to stores

- [ ] get all [checkoffs](#checkoffs)
- determine drop-dead time for:
  - [ ] stopping code churn
  - [ ] finalizing release in Github
  - [ ] pushing build from GitHub to WHO
- [ ] :construction: Upload all assets needed to Google Drive
  - ‼️ Note that this should include all source code, not just binaries ‼️
- [ ] WHO will **build and sign** (.apk/.ipa) the binaries using **their keys**
- [ ] WHO will fill in store information and upload .apk/.ipa

## Alpha testing (iOS only)

:construction: Can be removed if we don't use TestFlight ([discussion](https://github.com/WorldHealthOrganization/app/issues/132))

**[TestFlight requires a simplified version of app store review for > 25 people](https://developer.apple.com/testflight/), so we should alpha test at least on iOS with a small group before submission** 

1. [ ] recruit small sample of < 25 users from slack with a variety of different phone models
1. [ ] ask them to perform basic testing, ensure that app does not crash or look weird
1. [ ] once alpha testing passes, submit for testflight app store review

## Beta testing

1. [ ] publish beta testing URLs for both android and iOS to slack
1. [ ] collect beta test feedback in google doc
1. [ ] prioritize issues that need to be fixed before release
1. [ ] fix issues
1. [ ] [push to stores](#push-to-stores)

## Release!!

1. [ ] push beta version with no blocking/high priority issues to production

## Post-release marketing

1. [ ] send out press releases etc
