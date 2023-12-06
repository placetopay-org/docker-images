# Semantic release

Use semantic release in your repository

You can use this pipe to avoid copying lines of code like npm packages and configuration files of semantic release. When executing the pipe, a branch will be created with the name of the tag created using the 'versions' prefix.

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
- pipe: docker://placetopay/semantic-release:1.6.1
  variables:
    WEBHOOK_URL: 'MS_TEAMS_WEBHOOK_URL'
    USER_APP: 'CUSTOM_USER_APP'
    APP_PASSWORD: 'CUSTOM_APP_PASSWORD'
    ISSUE_PLATFORM_URL: 'ISSUE_PLATFORM_URL'
```

## Variables

| Variable                | Usage                                                                      |
|-------------------------|----------------------------------------------------------------------------|
| WEBHOOK_URL (*)         | ms teams channel dedicated to send messages.                               |
| USER_APP (*)            | A password to allow the user to get into the repository url.               |
| APP_PASSWORD (*)        | A user from the repo that have the permission to write into master branch. |
| ISSUE_PLATFORM_URL (*)  | The url of the Issue Platform referenced to the team.                      |

## Prerequisites

Only configure a webhook in your channel of microsoft teams

## Examples

Example:

```yaml
script:
  - pipe: docker://placetopay/semantic-release:1.6.1
    variables:
        WEBHOOK_URL: 'https://webhook.office.com/webhookb2/6f0793e1-f2e7-400f-b73d-f2f2e3be4936@2b5b7d77-f19b-4c6d-b180-5768c09ad43b/IncomingWebhook/808f'
        USER_APP: 'env_variable_user'
        PASSWORD_APP: 'env_variable_password'
        ISSUE_PLATFORM_URL: 'url_of_the_issue_platform'
```

# Package usage

**Prerequisites**

- Docker

#### Step 1 (Cloning the repository)

```shell
git clone git@bitbucket.org:placetopay/semantic-release.git
cd semantic-release
```

#### Step 2 (Edit config)

if you want extra functionality or modifications edit config in the file release.config.js with prevention


Build the image:

```
docker build -t my-test-image .
```

Run the container. Don't forget to pass in all required environment variables

```
docker run -e VAR_1=foo -e VAR_2=bar -w $(pwd) -v $(pwd):$(pwd) my-test-image
```
