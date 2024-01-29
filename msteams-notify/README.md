# MS Teams Notify

Sends a custom notification to [MSTeams](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using?tabs=cURL#setting-up-a-custom-incoming-webhook)(https://make.powerautomate.com/)

You can configure Microsoft Teams for your repository to get notifications on standard events, such as build failures and deployments and more. Use this pipe to send your own additional notifications at any point in your pipelines.

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
- pipe: placetopay/msteams-notify:2.0.0
  variables:
    WEBHOOK_URL: '<string>'
    MESSAGE: '<string>'
    FILENAME: '<string>'
    WEBHOOK_TYPE: '<string>'
```

## Variables

| Variable           | Usage                                                       |
| --------------------- | ----------------------------------------------------------- |
| WEBHOOK_URL (*) | Incoming Webhook URL. It is recommended to use a secure repository variable.  |
| MESSAGE (*)     | Notification attachment message. |
| WEBHOOK_TYPE (*)     | You can choose between POWER_AUTOMATE or INCOMING_WEBHOOK endpoint. |
| FILENAME ()     | Name of the CHANGELOG.md file to get the last changes of the tag. |

## Prerequisites

To send notifications to Microsoft Teams, you need an Incoming Webhook URL. You can follow the instructions [here](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook) to create one  or the second option is to configure a flow in power automate you can configure an endpoint [here](https://make.powerautomate.com) .


## Recomendations 

In the message variable it is only allowed in html format example: <b> Bold text </b> and no single quote or double quote can be used
and for the CHANGELOG.md file it must comply with the standard of [keepachangelog](http://keepachangelog.com/en/1.0.0/) with their respective tags and dates

## Examples

Basic example:
    
```yaml
script:
  - pipe: docker://placetopay/msteams-notify:2.0.0
    variables:
      WEBHOOK_URL: $WEBHOOK_URL
      MESSAGE: 'Hello, world!'
      WEBHOOK_TYPE: 'POWER_AUTOMATE'
```

You can pass the name of the changelog file, to get send your latest changes in the notification important
must comply with the specification (http://keepachangelog.com/en/1.0.0/)

```yaml
script:
  - pipe: docker://placetopay/msteams-notify:2.0.0
    variables:
      WEBHOOK_URL: $WEBHOOK_URL
      MESSAGE: 'build has exited with status $build_status"'
      FILENAME: 'CHANGELOG.md'
      WEBHOOK_TYPE: 'INCOMING_WEBHOOK'
```

# Package usage

**Prerequisites** 
- Python 3.8
- pip 22.1.2 
- Docker 


#### Step 1 (Cloning the repository)

```shell
git clone git@bitbucket.org:placetopay/msteams-notify.git
cd msteams-notify
```

#### Step 2 (Copying environment file)

```shell
cp .env.example .env
```
```shell
pip install -r requirements.txt
```

##### Running tests locally

Some tests require setting up a development account for the service that a pipe integrates with. Check out the readme


To run tests locally you need to: 

1. 
```shell
 pip install -r test/requirements.txt 
```

2. Make sure you've set up all required environment variables required for testing. Usually, these are the same variables that are required for a pipe to run.

3. Make sure your container have sock permissions 

```shell
chmod 777 /var/run/docker.sock
```
4. Run tests
    ```
    python3.8 -m pytest --verbose --capture=no test/unit/test_pipe_unit.py
    ```
    ```
    python3.8 -m pytest --verbose --capture=no test/feature/test_pipe_integration.py
    ```

In addition to that, you can manually build and run a docker container to test your changes:

Build the image:
```
docker build -t my-test-image .
```

Run the container. Don't forget to pass in all required environment variables

```
docker run -e VAR_1=foo -e VAR_2=bar -w $(pwd) -v $(pwd):$(pwd) my-test-image
```
