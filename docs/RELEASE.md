# Release process and check offs (client only)
______
since there is no server component at this time

## Checkoffs

## Product checks
1. [ ]  fidelity checks with mockups (design) \*
1. [ ]  go/nogo on individual features (engineering)
1. [ ]  release tag created (or maybe release branch, [discussion in #279](https://github.com/WorldHealthOrganization/app/issues/279))
1. [ ]  all automated tests pass
1. [ ]  LQA tests
1. [ ]  release notes generated

\* sometimes, engineering slightly changes the mockups for ease of implementation/scalability. Unit or integration tests won't catch this since they are focused on functionality. Design needs to have a final check to verify that such modifications (if any) work with the overall design.

## Compliance checks
### Security checks
:construction: waiting for input from Andrew https://github.com/WorldHealthOrganization/app/issues/269
### Privacy checks (from [#280](https://github.com/WorldHealthOrganization/app/issues/280))
Check how we stack up against these principles (qualitative evaluation, [details](release/privacy_check_details.md))
- [ ] Collection Limitation Principle
- [ ] Data Quality Principle
- [ ] Purpose Specification Principle
- [ ] Use Limitation Principle
- [ ] Security Safeguards Principle
- [ ] Openness Principle
- [ ] Individual Participation Principle
- [ ] Accountability Principle
### Legal checks (from [#17](https://github.com/WorldHealthOrganization/app/issues/17))
- [ ] 3rd party libraries / dependency license review
- [ ] CLA / developer license review
- [ ] Verify privacy policy vs actual system


## Store material check [(complete list)](release/store_asset_checks.md)

1. [ ] iOS text assets committed
1. [ ] android text assets committed
1. [ ] iOS screenshots committed
1. [ ] android screenshots committed 

## Final WHO sign off/approval
:construction: waiting for input from @brunobowden https://github.com/WorldHealthOrganization/app/issues/274

## Release processes

### Prepare to release

1. [ ] create release channel
1. [ ] create release tag/branch ([discussion in #279](https://github.com/WorldHealthOrganization/app/issues/279))
1. [ ] create Google Drive to push release to WHO **Temporary**
1. [ ] determine the gatekeepers for the following categories (this may change as people join or leave)
   1. [ ] engineering
   1. [ ] design
   1. [ ] compliance

### Push to stores

- [ ] get all [checkoffs](#checkoffs)
- determine drop-dead time for:
  - [ ] finalizing release in Github
  - [ ] pushing build from GitHub to WHO
- [ ] Upload all assets needed to Google Drive **Temporary**
  - ‼️Note that this should include all source code, not just binaries‼️
- [ ] WHO will **build and sign** (.apk/.ipa) the binaries using their keys
- [ ] WHO will fill in store information and upload .apk/.ipa

## Alpha testing (iOS only)

:construction: Can be removed if we don't use TestFlight, see https://github.com/WorldHealthOrganization/app/issues/132

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
