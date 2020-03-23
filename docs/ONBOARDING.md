# Getting Started

If you're here, that means you're interested in being a part of the volunteer effort. Welcome! We're glad to have you.

The goal of this document is to give you a starting point for where to find the resources you need to get up to speed. This is by no means an exhaustive document, and I'm sure that we'll be missing some important items here, so if you're missing something, just ask and we will try to update this document.

First thing's first - in order to keep track of everyone working on the project, please add yourself to the project roster: https://docs.google.com/spreadsheets/d/1jt4xrXWUnsh8DmtawNV4XGBj8RAdgn-d7ckgL2qEXPM/edit#gid=0

Next - join the [Slack](https://join.slack.com/t/who-app/shared_invite/zt-cylowls6-Q7iQPvTAenkN_Yb9MLxVIw) and introduce yourself in the #intros channel! To avoid confusion, please include your GitHub username and timezone in your Slack display name, e.g. `Hunter Spinks, hspinks, PST`.

If you need access to issues & tasks on GitHub, please add your GitHub username to [this ticket](https://github.com/WorldHealthOrganization/app/issues/99) and [Sam Mousa](https://github.com/SamMousa) can add you with the appropriate roles.

## Daily Standup

We have a regular, daily all-hands over Zoom at 11am PDT. Details on the standups and links to join can be found pinned in the #standup channel on Slack.

## Resources

Where to find answers to your questions:

* GitHub Issues: https://github.com/WorldHealthOrganization/app/issues
* Slack: https://join.slack.com/t/who-app/shared_invite/zt-cylowls6-Q7iQPvTAenkN_Yb9MLxVIw
* Initial project brief (will be updated): https://docs.google.com/document/d/1isNMLpwI2iUY92KPwJHfY7kQnpN3oCuUl6c94J7Qmhs
* Rough engineering backlog: https://github.com/WorldHealthOrganization/app/projects/1
* Most up-to-date app design spec: https://github.com/WorldHealthOrganization/app/issues/129
* Most up-to-date preview of app in development: https://preview.whoapp.org/about

Most discussion will be taking place in a combination of Slack and GitHub issues, so those are your best places to start.

### Key Slack Channels

For key conversations related to each major area, please see the following Slack channels:

* `#eng` - Engineering
* `#design` - Design
* `#product` - Product
* `#intros` - the place every new member should introduce themselves
* `#standup` - communication around our daily standup (including details how to join)
* `#techtointegrate` - sharing other projects or libraries that could have synergies with our goals
* `#futureideas` - sharing ideas for downstream features

## Point People

This is very much a committee effort, and we are moving quickly enough that we have to self-organize as much as we can. You're encouraged to step up and find places to contribute rather than relying on anyone to tell you what to do. Even in just the first couple days of the project, there has been incredible effort from a lot of contributors. With that said, there are a couple people helping play point around different areas that are trying to keep a pulse of everything going on in those areas:

* Karen Wong ([asianfoodlab](https://github.com/asianfoodlab)) - all things Product
* Vivian Cromwell ([viviancromwell](https://github.com/viviancromwell)) - all things Design
* Hunter Spinks ([hspinks](https://github.com/hspinks)) - all things Engineering

# Building and Running

Please review the [Contributor Guidelines](https://github.com/WorldHealthOrganization/app/blob/master/CONTRIBUTING.md) before making any contributions to the code.

This app uses a monorepo structure with the client application in the `client` directory and all server-related code in the `server` directory (currently only the `client/ionic` directory is used).

## Client

The client app will be built initially using [Ionic React](https://ionicframework.com/docs/react). To get started, clone the repo and from the `client/ionic` directory run:

```
npm install -g @ionic/cli
npm install
ionic serve
```

To run on Android, from the `client/ionic` directory run:

```
ionic build
ionic capacitor copy android
npx cap update android
ionic capacitor run android -l --host=YOUR_IP_ADDRESS
```

To run on iOS, from the `client/ionic` directory run:

```
ionic build
ionic capacitor copy ios
ionic capacitor run ios
```

### Troubleshooting

If you are getting an `unable to open file (in target "App" in project "App")` error message when attempting to build the iOS app in Xcode, this may be related to an issue with needing to install pods from CocoaPods that we are currently investigating. Ensure that your ruby and CocoaPods are up to date, then run `pod install` from the `client/ionic/ios/App` directory. If that install succeeds, you should be able to build your iOS app without issue.

## Server

TODO(crazybob)
