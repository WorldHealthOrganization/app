# Getting Started

**To everyone who has jumped in wanting to help:** We are humbled at the outpouring of support we have received from all over the world and are eager to have you contribute and apologize that we are still in the early process of figuring out how to manage all the contributions. Please bear with us while we get an initial version out the door and split out into smaller teams working in parallel, when we can then on-board more volunteers. Until then, please keep filing issues, and fill out the [volunteer form here](https://forms.gle/FUugWvUVvMcV3dLJA) and we’ll get back in touch.

## Resources

Where to find answers to your questions:

- GitHub Issues: https://github.com/WorldHealthOrganization/app/issues
- Slack: _We apologize, but the Slack is closed to new contributors until initial app release_

### Slack

Please add your GitHub URL to your Slack profile. For key conversations related to each major area, please see the following Slack channels:

- `#eng` - Engineering
- `#design` - Design
- `#product` - Product
- `#intros` - the place every new member should introduce themselves
- `#standup` - communication around our daily standup (including details how to join)
- `#techtointegrate` - sharing other projects or libraries that could have synergies with our goals
- `#futureideas` - sharing ideas for downstream features

## Point People

This is very much a team effort, and we are moving quickly enough that we have to self-organize as much as we can. You're encouraged to step up and find places to contribute rather than relying on anyone to tell you what to do. With that said, there are a couple people helping play point around different areas that are trying to keep a pulse of everything going on in those areas:

- Project Creator: Daniel Kraft
- Overall Management: Bruno Bowden
- Product Lead: TBD
- Design Lead: TBD
- Engineering Lead: TBD

- Alumni Leads: Dean Hachamovitch, David Kaneda, Bob Lee, Advay Mengle, Hunter Spinks, Karen Wong

# Development

Please review the [Contributor Guidelines](CONTRIBUTING.md) before making any contributions to the code.

This app uses a monorepo structure with the client application in the `client` directory and all server-related code in the `server` directory (currently only the `client` directory is used).

Engineering design documents are kept in [devdesign](devdesign/README.md).

## Initial Setup

Clone the repo and run from the root of the local clone:

```sh
./dev-setup.sh
```

## Client

See [client/README.md](../client/README.md).

## Server

See [server/README.md](../server/README.md).

## Troubleshooting

List of common problems and solutions during development.

### PR Checks

#### Policy Check

Error: "Policy Check / Check source code for policy violations"

Solution: Click on the "Details" link to the right and search for the **second** "Add" to find the issue:

```sh
❌ L172 of client/assets/content_bundles/your_questions_answered.en.yaml:
<li>Place the mask on your face covering your nose, mouth and chin, making sure that there are no gaps between your face and the mask</li>

ℹ️ Add '8731da43a61f8fae0293d877c558ad655fa242fcb74eba16ad001272bae3bfe6 client/assets/content_bundles/your_questions_answered.en.yaml' to ./.github/policy-ignored-lines.txt to ignore this issue
```

Check the prior line from the source code to see it's a mistaken use of profanity. If it is, then update the PR and the profanity check will then pass.

In the above example, it's a false positive. In which case follow the instructions to add a line to [.github/policy-ignored-lines.txt](../.github/policy-ignored-lines.txt). See this example [PR 1550](https://github.com/WorldHealthOrganization/app/pull/1550).
