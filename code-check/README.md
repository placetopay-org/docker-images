# Bitbucket Pipelines Pipe: Code Check

## Check backend and frontend code efficiently

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
script:
    - pipe: docker://placetopay/code-check
      variables:
        CHECK_BACKEND: 'ON'
        CHECK_FRONTEND: 'ON'
```

## Variables

| Variable              | Usage                                                       |
| --------------------- | ----------------------------------------------------------- |
| CHECK_BACKEND         | check the backend, value (ON - OFF).                        |
| CHECK_FRONTEND        | check the frontend, value (ON - OFF).             (eslint)  |
| DEBUG                 | Turn on extra debug information. Default: false.            |

_(*) = required variable._


## Support
If you’d like help with this pipe, or you have an issue or feature request, let us know.
The pipe is maintained by miguel.lopez@evertecinc.com.

If you’re reporting an issue, please include:

- the version of the pipe
- relevant logs and error messages
- steps to reproduce


## License
Copyright (c) 2022 PlaceToPay.
Apache 2.0 licensed, see [LICENSE.txt](latest/LICENSE.txt) file.
