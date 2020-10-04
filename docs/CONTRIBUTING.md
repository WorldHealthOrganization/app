# Contributing

First, make sure you've followed the [onboarding documentation](ONBOARDING.md).

## Process Guidelines

Please abide by a few rules to keep us safe and sane:

- Enable 2FA for your account, and use hardware keys if possible (mandatory if you are a committer)
- Assign issues to yourself before you begin work to avoid duplicate effort. If someone else already has the issue, please sync up before-hand.
- Assign PRs to the one or more reviewers whose approval you require. All other reviewers are nice-to-have.
- If you are blocked on someone else, be bold and assign the issue or PR directly to them so they are aware.
- If you have a PR assigned to you, consider it a high priority as you are likely blocking your colleague from continuing to code.

## Pull Requests

Please follow the [default Pull Request template](../.github/pull_request_template.md) when creating your PR, and follow these rules:

- For authors, before you submit a PR for review:
  - Add your name to the end of the `team` array in the [docs/credits.yaml](../docs/credits.yaml) contributor list if it's your first commit.
  - Make sure the commit history you propose reflects meaningful chunks of work each of which is of submittable quality and properly licensed, instead of reflecting your iterative development/debugging process as you add or remove code. For example your corrections during code review should be squashed into the appropriate relevant original commit, not a separate commit just for fixes.
  - GitHub Email address needs to match your git author email address.
  - For each dependency you add, please acknowledge it in your PR description and describe why you chose it, its license, and a summary of how widely it is used in the open source community (do known apps use it? does it have known backers?)
- For committers:
  - 2 person rule - any code can be committed only with the approval of at least one person with commit authority who is not the author of the PR (applies to admins too)
  - Committers must use the `Squash and Merge` function for merging a PR.

## Commit Message Guidelines

We would like to keep the process as lightweight as possible, so we will not be overly strict in enforcing this, but please try to follow these guidelines when committing. Structure your commit messages like so (some pieces are optional):

```
<gitmoji> <type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

The two required pieces are `<type>` and `<subject>`. `<type>` should be one of the following:

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **test**: Adding tests or updating existing tests
- **ci**: Changes to CI configuration
- **perf**: A code change that improves performance

The `<subject>` should describe the change succinctly, in the imperative, present tense (e.g. "change" not "changed" or "changes"). Do not capitalize the first letter, and do not include a period at the end.

Even if you just include type and subject, you're going a long way towards making our commit history readable! Here are some examples:

```
feat: add TopNav component
```

```
docs: update CONTRIBUTING with commit guidelines
```

```
fix: catch NetworkNotAvailable exceptions
```

To add more detail to your commit message and/or improve readability, you can add a couple more elements to the first line with a `<gitmoji>` and/or `<scope>`.

Optional gitmojis are just GitHub-supported emojis that give you a quick visual clue to what the commit was doing. These don't have to follow any strict guidelines but should be descriptive. Common ones include :sparkles: for new features, :bug: for bugfixes, :wrench: for config updates, :construction: for works in progress, :ok_hand: for responding to PR comments, :pencil: for writing docs, etc. There's a full list to inspire you [here](https://gitmoji.carloscuesta.me/) (with handy copy-paste for the gitmojis).

The scope is an optional place to give more context to which section of the codebase your commit is relevant to. For example, if your commit adds something to the triage surveys, your scope could be `surveys`.

Examples including gitmoji and/or scope:

```
:sparkles: feat(surveys): add new survey definition
```

```
:pencil: docs: add Slack link to ONBOARDING
```

```
:wrench: ci: build Android app on MacOS
```

The optional `<body>` of a commit message should go into more detail on anything that needs additional clarity beyond the subject, which should be kept short. Just as in the subject, use the imperative, present tense.

The optional `<footer>` of a commit message is where you should list any breaking changes or reference GitHub issues that this commit closes.

Full example:

```
:sparkles: feat(i18n): use react-intl instead of react-i18next

Remove old react-i18next code and integrate react-intl instead

Closes #100
```
