# issue-checklist-checker

GitHub Action for making sure that checklists are checked when a new Issue is opened. This is intended to be used with checklists in Issue templates to encourage contributors to follow our guidelines for Issues.

## Usage

```yaml
name: Check Issue Checklist
on: [issues]

jobs:
  check-checklist:
    name: Check that an Issue's checklist has been filled out
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Require issue checklist
      uses: ./.github/actions/issue-checklist-checker
      continue-on-error: true
      with:
        incomplete-checklist-pattern: '^- \[ ]'
        incomplete-comment: 'Please ensure you have filled out the checklist'
        incomplete-label: 'incomplete'
        repo-token: ${{ secrets.GITHUB_TOKEN }}

```

### Inputs

| Input | Required? | Description |
| ----- | --------- | ----------- |
| `incomplete-checklist-pattern` | **required** | a string that is parseable into a JavaScript RegExp; if the RegExp matches any line in the Issue, the Issue checklist will be incomplete |
| `incomplete-comment` | optional | the text of a comment that will automatically be left on an Issue with an incomplete checklist; if omitted, no comment will be left |
| `incomplete-label` | **required** | the name of the label that will be used to mark Issues as incomplete |
| `repo-token` | **required** | the [GITHUB_TOKEN](https://help.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token) providing access to the repo |

## Incomplete Checklist Pattern

Checklists are created in GitHub comment bodies by starting a line with `- [ ]` or `* [ ]`. Currently, this repo's Issue template uses `- [ ]` for the recommended checks before opening an issue. If an Issue author wants to use a checklist for something that should not be completed before opening the issue, it is recommended to use `* [ ]` instead to separate the two, allowing this Action to just use `^- \[ ]` as its checklist search pattern.

#### TODO

In the future, to avoid that issue, this Action could read from the repo's Issue templates to attempt to match the specific patterns used in the templates.

## Building

After making any edits to this Action, make sure to run `npm run build` and include the generated file `dist/index.js` in the commit. The generated file must be committed to include the dependencies. The build script uses [`@zeit/ncc`](https://github.com/zeit/ncc) to compile the TypeScript into a single JavaScript file.

## More

See [actions/typescript-action](https://github.com/actions/typescript-action) for more.
