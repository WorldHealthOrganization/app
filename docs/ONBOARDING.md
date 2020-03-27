# Getting Started

If you're here, that means you're interested in being a part of the volunteer effort. Welcome! We're glad to have you.

The goal of this document is to give you a starting point for where to find the resources you need to get up to speed. This is by no means an exhaustive document, and I'm sure that we'll be missing some important items here, so if you're missing something, just ask and we will try to update this document.

First thing's first - in order to keep track of everyone working on the project, please add yourself to the project roster: https://forms.gle/FUugWvUVvMcV3dLJA

Next - join the [Slack](https://join.slack.com/t/who-app/shared_invite/zt-cx6ycppt-ccqPJ7ZSGy3~77gSByexJw) and introduce yourself in the #intros channel! To avoid confusion, please include your GitHub username and timezone in your Slack display name, e.g. `Hunter Spinks, hspinks, PST`.

If you need access to issues & tasks on GitHub, please add your GitHub username to [this ticket](https://github.com/WorldHealthOrganization/app/issues/99) and [Sam Mousa](https://github.com/SamMousa) can add you with the appropriate roles.

## Daily Standup

We have a regular, daily all-hands over Zoom at 11am PDT. Details on the standups and links to join can be found pinned in the #standup channel on Slack.

## Resources

Where to find answers to your questions:

* GitHub Issues: https://github.com/WorldHealthOrganization/app/issues
* Slack: https://join.slack.com/t/who-app/shared_invite/zt-cx6ycppt-ccqPJ7ZSGy3~77gSByexJw
* Initial project brief (will be updated): https://docs.google.com/document/d/1isNMLpwI2iUY92KPwJHfY7kQnpN3oCuUl6c94J7Qmhs
* WIP product roadmap: [ROADMAP.md](ROADMAP.md)
* Rough engineering backlog: https://github.com/WorldHealthOrganization/app/projects/1
* Most up-to-date app design spec: https://github.com/WorldHealthOrganization/app/issues/129
* Most up-to-date preview of app in development: https://preview.whoapp.org

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

Please review the [Contributor Guidelines](CONTRIBUTING.md) before making any contributions to the code.

This app uses a monorepo structure with the client application in the `client` directory and all server-related code in the `server` directory (currently only the `client/flutter` directory is used).

## Client

Follow flutter installation instructions [here](https://flutter.dev/docs/get-started/install).

Clone the repo and from the  `client/flutter` directory, run 
```
flutter run
```

### Troubleshooting

* If you built the Ionic client previously and see a warning about husky (git hooks), we no longer use husky git hooks. As long as you have no personal git hooks, run: `pushd .git/hooks && ( ls | grep \.sample -v | xargs rm ) && popd` from repo root after you sync.

## Server

TODO(crazybob)
