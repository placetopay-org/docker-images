#!/usr/bin/env bash
set -e

validate() {
    #required parameters
    : AWS_REGION=${AWS_REGION:?'AWS_REGION variable missing.'}
    : ROLE_NAME_REPOSITORY_ARN=${ROLE_NAME_REPOSITORY_ARN:?'ROLE_NAME_REPOSITORY_ARN variable missing.'}
    : DEPLOYMENT_ROL_ARN=${DEPLOYMENT_ROL_ARN:?'DEPLOYMENT_ROL variable missing.'}
    : STAGE=${STAGE:?'STAGE variable missing.'}
}

run_pipe() {
    export CREDS=$(aws sts assume-role-with-web-identity --role-arn $ROLE_NAME_REPOSITORY_ARN --role-session-name cicd-oidc-ss --web-identity-token "$BITBUCKET_STEP_OIDC_TOKEN" | jq '.Credentials')
    printf "[cicd_role_ss]\naws_access_key_id=$(echo $CREDS | jq '.AccessKeyId' | tr -d '"')\naws_secret_access_key=$(echo $CREDS | jq '.SecretAccessKey' | tr -d '"')\naws_session_token=$(echo $CREDS | jq '.SessionToken' | tr -d '"')" >/root/.aws/credentials

    export CREDS=$(aws sts assume-role --role-arn $DEPLOYMENT_ROL_ARN --role-session-name deployment-$STAGE --profile cicd_role_ss | jq '.Credentials')
    printf "[default]\naws_access_key_id=$(echo $CREDS | jq '.AccessKeyId' | tr -d '"')\naws_secret_access_key=$(echo $CREDS | jq '.SecretAccessKey' | tr -d '"')\naws_session_token=$(echo $CREDS | jq '.SessionToken' | tr -d '"')" >/root/.aws/credentials

    node /create_env/index.js --REGION $AWS_REGION --SECRET_NAME $SECRET_NAME > .env

    sls deploy --aws-profile default --verbose --stage=$STAGE --region=$AWS_REGION

    if [ "${RUN_MIGRATIONS}" != "" ]; then
        sls invoke --aws-profile default --stage=$STAGE --region=$AWS_REGION -f artisan -d "migrate --force --no-interaction" -l
    fi

    if [ "${CLEAR_CACHE_LARAVEL}" != "" ]; then
        sls invoke --aws-profile default --stage=$STAGE --region=$AWS_REGION -f artisan -d "optimize:clear" -l
    fi
}

validate
run_pipe
