# Bref serveless deploy

Deploy your bref applications using the serverless framework

You can use this pipe to avoid copying lines of code like aws authentication and installations needed to deploy the
application.

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
- pipe: docker://placetopay/bref-deploy:1.8.2
  variables:
    AWS_REGION: '<string>'
    ROLE_NAME_REPOSITORY_ARN: '<string>'
    DEPLOYMENT_ROL_ARN: '<string>'
    STAGE: '<string>'
    SECRET_NAME: name_secret_aws
```

## Variables

| Variable                     | Usage                                                 |
|------------------------------|-------------------------------------------------------|
| AWS_REGION (*)               | region where the cloudformation template is deployed. |
| ROLE_NAME_REPOSITORY_ARN (*) | assume role ARN with web identity.                    |
| DEPLOYMENT_ROL_ARN (*)       | deployment rol arn of profile.                        |
| STAGE (*)                    | .                                                     |
| RUN_MIGRATIONS               | Si se define se ejecuta `php artisan migrate`         |
| CLEAR_CACHE_LARAVEL          | Si se define se ejecuta `php artisan optimize:clear`  |
| SECRET_NAME                  | Nombre del secret para crear el .env                  |

## Prerequisites

Before executing the pipe in your pipeline you should previously execute the composer steps and the environment
variables, you must also have the respective OIDC configured in your repository

## Examples

Example:

```yaml
script:
  - pipe: docker://placetopay/bref-deploy:1.8.2
    variables:
      AWS_REGION: 'us-east-1'
      ROLE_NAME_REPOSITORY_ARN: 'arn:aws:iam::{$ID}:role/cicd/{$REPOSITORY}-cicd-role'
      DEPLOYMENT_ROL_ARN: 'arn:aws:iam::{$ID}:role/{$REPOSITORY}-serverless-deployment-role'
      STAGE: 'dev'
      SECRET_NAME: 'secret_name_aws'
```

# Package usage

**Prerequisites**

- Docker

#### Step 1 (Cloning the repository)

```shell
git clone git@bitbucket.org:placetopay/bref-deploy.git
cd bref-deploy
```

Build the image:

```
docker build -t my-test-image .
```

Run the container. Don't forget to pass in all required environment variables

```
docker run -e VAR_1=foo -e VAR_2=bar -w $(pwd) -v $(pwd):$(pwd) my-test-image
```
