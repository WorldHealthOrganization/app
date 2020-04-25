# Getting Started

**To everyone who has jumped in wanting to help:** We are humbled at the outpouring of support we have received from all over the world and are eager to have you contribute and apologize that we are still in the early process of figuring out how to manage all the contributions.  Please bear with us while we get an initial version out the door and split out into smaller teams working in parallel, when we can then on-board more volunteers.  Until then, please keep filing issues, and fill out the [volunteer form here](https://forms.gle/FUugWvUVvMcV3dLJA) and we’ll get back in touch.

## Standup

All-hands meetings will happen over Zoom every Monday and Thursday at 11am PDT, and engineering-only standups are daily at 11am PDT.

## Resources

Where to find answers to your questions:

* GitHub Issues: https://github.com/WorldHealthOrganization/app/issues
* Slack: _We apologize, but the Slack is closed to new contributors until initial app release_
* WIP product roadmap: [ROADMAP.md](ROADMAP.md)
* Rough engineering backlog: https://github.com/WorldHealthOrganization/app/projects/1
* Most up-to-date preview of app in development: _Will be re-added soon_

### Slack

Please add your GitHub URL to your Slack profile. For key conversations related to each major area, please see the following Slack channels:

* `#eng` - Engineering
* `#design` - Design
* `#product` - Product
* `#intros` - the place every new member should introduce themselves
* `#standup` - communication around our daily standup (including details how to join)
* `#techtointegrate` - sharing other projects or libraries that could have synergies with our goals
* `#futureideas` - sharing ideas for downstream features

## Point People

This is very much a committee effort, and we are moving quickly enough that we have to self-organize as much as we can. You're encouraged to step up and find places to contribute rather than relying on anyone to tell you what to do. Even in just the first couple days of the project, there has been incredible effort from a lot of contributors. With that said, there are a couple people helping play point around different areas that are trying to keep a pulse of everything going on in those areas:

* Product: Karen Wong ([asianfoodlab](https://github.com/asianfoodlab))
* Design: _update to come_
* Engineering: Hunter Spinks ([hspinks](https://github.com/hspinks)) and Advay Mengle ([advayDev1](https://github.com/advayDev1))

# Building and Running

Please review the [Contributor Guidelines](CONTRIBUTING.md) before making any contributions to the code.

This app uses a monorepo structure with the client application in the `client` directory and all server-related code in the `server` directory (currently only the `client/flutter` directory is used).

## Initial Setup

Clone the repo and run from the root of the local clone:
```
./dev-setup.sh
```

## Client

See [client/flutter/README.md](client/flutter/README.md).

## Server

See [server/README.md](server/README.md).
