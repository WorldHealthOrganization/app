fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## Android
### android distribute_staging
```
fastlane android distribute_staging
```
Submit to firebase app distribution on who-myhealth-staging (for testing the distribution process only; who-myhealth-staging is not actually used for app distribution)
### android distribute
```
fastlane android distribute
```
Submit to firebase app distribution on who-myhealth-production

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
