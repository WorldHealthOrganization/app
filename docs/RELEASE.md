# Release process and check offs (client only)
______
since there is no server component at this time

## Checkoffs

## Product checks
1. [ ]  fidelity checks with mockups (design) \*
1. [ ]  go/nogo on individual features (engineering)
1. [ ]  release tag created
1. [ ]  all automated tests pass
1. [ ]  all internationalization tests pass
1. [ ]  release notes generated

\* sometimes, engineering slightly changes the mockups for ease of implementation/scalability. Unit or integration tests won't catch this since they are focused on functionality. Design needs to have a final check to verify that such modifications (if any) work with the overall design.

## Security checks
TBD: Andrew will send a list

## Store material check

TODO: Maintain full list of assets required in template
1. [ ] iOS text assets committed
1. [ ] android text assets committed
1. [ ] iOS screenshots committed
1. [ ] android screenshots committed 

## Final WHO sign off/approval
??? not sure what the process for this is

## Release processes

### Push to stores

1. [ ] get all [checkoffs](#checkoffs)
1. [ ] publish .apk and .ipa to github using automated build
1. [ ] WHO will fill in store information and upload apk/ipa

## Alpha testing (iOS only)

**[TestFlight requires a simplified version of app store review for > 25 people](https://developer.apple.com/testflight/), so we should alpha test
at least on iOS with a small group before submission**
1. [ ] recruit small sample of < 25 users from slack with a variety of different phone models
1. [ ] ask them to perform basic testing, ensure that app does not crash or look weird
1. [ ] once alpha testing passes, submit for testflight app store review

## Beta testing

1. [ ] publish beta testing URLs for both android and iOS to slack
1. [ ] collect beta test feedback in google doc
1. [ ] prioritize issues that need to be fixed before release
1. [ ] fix issues
1. [ ] [push to stores](push-to-stores)

## Release!!

1. [ ] push beta version with no blocking/high priority issues to production

## Post-release marketing

1. [ ] send out press releases etc
