const teamsWebHook = process.env.WEBHOOK_URL

const repoOwner = process.env.BITBUCKET_REPO_OWNER
const repoSlug = process.env.BITBUCKET_REPO_SLUG
const user = process.env.USER_APP
const password = process.env.APP_PASSWORD

const repositoryUrl = `https://${user}:${password}@bitbucket.org/${repoOwner}/${repoSlug}`
const clickUpUrl = process.env.ISSUE_PLATFORM_URL

module.exports = {
    "repositoryUrl": repositoryUrl,
    tagFormat: '${version}',
    branches: ['master'],
    "plugins": [
        ["@semantic-release/commit-analyzer", {
            "preset": "angular",
            "releaseRules": [{
                "type": "*!",
                "release": "major"
            }, {
                "type": "feat",
                "release": "minor"
            }, {
                "type": "fix",
                "release": "patch"
            }, {
                "type": "chore",
                "release": "patch"
            }, {
                "type": "refactor",
                "release": "patch"
            }, {
                "type": "ci",
                "release": "patch"
            }, {
                "type": "docs",
                "release": "patch"
            }, {
                "type": "style",
                "release": "patch"
            }, {
                "type": "perf",
                "release": "patch"
            }]
        }],
        ["@semantic-release/release-notes-generator", {
            "parserOpts": {
                "noteKeywords": ["BREAKING CHANGE:"]
            },
            "preset": "conventionalcommits",
            "presetConfig": {
                "commitUrlFormat": "{{host}}/{{owner}}/{{repository}}/{{@root.commit}}/{{hash}}",
                "compareUrlFormat": "{{host}}/{{owner}}/{{repository}}/compare/{{currentTag}}..{{previousTag}}",
                "issueUrlFormat": `${clickUpUrl}{{id}}`,
                "issuePrefixes": ["#"],
                "types": [{
                    "type": "*!",
                    "section": "Breaking Change",
                    "hidden": false
                }, {
                    "type": "feat",
                    "section": "Feature",
                    "hidden": false
                }, {
                    "type": "fix",
                    "section": "Bugfix",
                    "hidden": false
                }, {
                    "type": "chore",
                    "section": "Dependencies",
                    "hidden": false
                }, {
                    "type": "refactor",
                    "section": "Refactor",
                    "hidden": false
                }, {
                    "type": "ci",
                    "section": "Continuous Integration",
                    "hidden": false
                }, {
                    "type": "docs",
                    "section": "Docs",
                    "hidden": false
                }, {
                    "type": "style",
                    "section": "Style",
                    "hidden": false
                }, {
                    "type": "perf",
                    "section": "Performance",
                    "hidden": false
                }]
            }
        }],
        ["@semantic-release/changelog", {
            "changelogFile": "CHANGELOG.md"
        }],
        ["@semantic-release/git", {
            "assets": ["CHANGELOG.md"]
        }],
        ["semantic-release-ms-teams", {
            "webhookUrl": teamsWebHook,
            "title": "A new version has been released",
            "showContributors": false,
            "notifyInDryRun": true
        }]
    ],
}
