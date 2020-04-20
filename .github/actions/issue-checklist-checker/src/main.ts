import * as core from '@actions/core';
import * as github from '@actions/github';

interface RequireIssueChecklistInputs {
    incompleteChecklistRegex: RegExp;
    incompleteComment: string;
    incompleteLabel: string;
    repoToken: string;
}

async function run(): Promise<void> {
    try {
        const {
            incompleteChecklistRegex,
            incompleteComment,
            incompleteLabel,
            repoToken
        } = getInputs();
        
        const octokit = new github.GitHub(repoToken);
        const issueNumber = github.context.issue.number;
        core.debug('Testing Issue #' + issueNumber);

        const {data: issue} = await octokit.issues.get({
            owner: github.context.repo.owner,
            repo: github.context.repo.repo,
            issue_number: issueNumber
        });

        const issueLines = issue.body.split(/\r?\n/);
        var foundPattern = false;

        issueLines.some((line: string) => {
            foundPattern = incompleteChecklistRegex.test(line.trim());
            return foundPattern;
        });

        const issueLabelNames = issue.labels.map(labelItem => labelItem.name);
        const hasLabel = issueLabelNames.includes(incompleteLabel);

        if (foundPattern) {
            core.debug('Issue Checklist Incomplete');

            if (!hasLabel) {
                core.debug('Adding Label');

                // By default, this will create the label if it does not already exist
                await octokit.issues.addLabels({
                    owner: github.context.repo.owner,
                    repo: github.context.repo.repo,
                    issue_number: issue.number,
                    labels: [incompleteLabel]
                });
                if (incompleteComment) {
                    core.debug('Adding Comment');

                    await octokit.issues.createComment({
                        owner: github.context.repo.owner,
                        repo: github.context.repo.repo,
                        issue_number: issue.number,
                        body: incompleteComment
                    });
                }
            }
        } else {
            core.debug('Issue Checklist Complete');

            if (hasLabel) {
                core.debug('Removing Label');

                await octokit.issues.removeLabel({
                    owner: github.context.repo.owner,
                    repo: github.context.repo.repo,
                    issue_number: issue.number,
                    name: incompleteLabel
                });
            }
        }
    } catch (error) {
        core.setFailed(error.message);
    }
}

function getInputs(): RequireIssueChecklistInputs {
    const repoToken: string = core.getInput('repo-token', { required: true });
    const incompleteComment: string = core.getInput('incomplete-comment', { required: false });
    const incompleteLabel: string = core.getInput('incomplete-label', { required: false });
    const incompleteChecklistPattern: string = core.getInput('incomplete-checklist-pattern', { required: true });
    const incompleteChecklistRegex = new RegExp(incompleteChecklistPattern);
    return {
        incompleteChecklistRegex,
        incompleteComment,
        incompleteLabel,
        repoToken
    };
}

run()
