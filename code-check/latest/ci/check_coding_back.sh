#!/usr/bin/env bash

set -e

cd $BITBUCKET_CLONE_DIR

# save just in case
BACKUP_PROXY=$(git config "http.${BITBUCKET_GIT_HTTP_ORIGIN}.proxy")
# replace
git config "http.${BITBUCKET_GIT_HTTP_ORIGIN}.proxy" http://host.docker.internal:29418

git fetch origin $BITBUCKET_PR_DESTINATION_BRANCH:refs/remotes/origin/$BITBUCKET_PR_DESTINATION_BRANCH
git fetch origin $BITBUCKET_BRANCH:refs/remotes/origin/$BITBUCKET_BRANCH

STAGED_FILES_CMD=`git diff origin/$BITBUCKET_PR_DESTINATION_BRANCH origin/$BITBUCKET_BRANCH --name-only --diff-filter=ACMR | grep .php` || true

for FILE in $STAGED_FILES_CMD
do
    echo 'Reviewing file: '$FILE
    php-cs-fixer fix --verbose --config=/home/.php-cs-fixer.php $FILE --dry-run --stop-on-violation --using-cache=no
done

# restore just in case
git config "http.${BITBUCKET_GIT_HTTP_ORIGIN}.proxy" "$BACKUP_PROXY"