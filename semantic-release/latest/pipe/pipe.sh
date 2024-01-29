#!/usr/bin/env bash

validate() {
     #required parameters
    : WEBHOOK_URL = ${WEBHOOK_URL:?'WEBHOOK_URL variable missing.'}
    : USER_APP = ${USER_APP:?'USER_APP variable missing.'}
    : APP_PASSWORD = ${APP_PASSWORD:?'APP_PASSWORD variable missing.'}
    : ISSUE_PLATFORM_URL = ${ISSUE_PLATFORM_URL:?'ISSUE_PLATFORM_URL variable missing.'}
}

create_branch_from_tag() {
    tag=$(git describe --abbrev=0 --tags)
    git branch "versions/$tag"
    git checkout "versions/$tag"
    git push origin "versions/$tag"
}

run_pipe() {
    printenv
    git config --global --add safe.directory /opt/atlassian/pipelines/agent/build
    git config http.${BITBUCKET_GIT_HTTP_ORIGIN}.proxy http://host.docker.internal:29418/
    npx semantic-release
    create_branch_from_tag
}


validate
run_pipe || exit 1
