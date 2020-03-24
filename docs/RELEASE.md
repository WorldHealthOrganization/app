# Release process and check offs (client only)
______
since there is no server component at this time

## Prepare release
1. [ ]  User testing on mockups (design)
1. [ ]  go/nogo on individual features (engineering)
1. [ ]  create release tag for the selected features
1. [ ]  all automated tests pass
1. [ ]  all internationalization tests pass
1. [ ]  generate release notes

## Security checks
TBD: Andrew will send a list

## Collect store materials

TODO: Maintain full list of assets required in template
1. [ ] generate iOS text assets
1. [ ] generate android text assets
1. [ ] generate iOS screenshots
1. [ ] generate android screenshots

## Final WHO sign off/approval
??? not sure what the process for this is

## Push to the stores for beta testing

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
1. [ ] ask WHO to push fixed version to stores

## Release!!

1. [ ] when no high priority/blocking issues left, publish on both stores

## Post-release marketing

1. [ ] send out press releases etc
