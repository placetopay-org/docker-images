# Placetopay - Docker Images

Custom docker images with [Newrelic](https://newrelic.com/) for php 7.4 and php 8.

## Getting Started 

These instructions will give you some containers on your local machine available to publish on docker hub.

### Build and/or Publish

[build.sh](build.sh) is a script with docker commands to make the process easier.

Build an image:

```
./build.sh php-vapor php74
```

Override the tag to push:

```
./build.sh php-image php74 -p latest
```

__Note: There are images with php 8 for production (php80) and for pipelines (php80-pipeline).__

Build and publish an image:

```
./build.sh php-vapor php74 -p
```

__Note:__ You need to be logged in docker hub to publish with `docker login` in the placetopay account.

## Resources

- Laravel Vapor Dockerfiles - https://github.com/laravel/vapor-dockerfiles.
- Integrate Newrelic in Laravel Vapor - https://dev.to/davidv99/integrate-newrelic-in-laravel-vapor-4o13.
- Bref-deploy - https://github.com/placetopay-org/docker-images/blob/master/bref-deploy/README.md.
- Code-check - https://github.com/placetopay-org/docker-images/blob/master/code-check/README.md.
- MsTeams-notify - https://github.com/placetopay-org/docker-images/blob/master/msteams-notify/README.md.
- Semantic-release - https://github.com/placetopay-org/docker-images/blob/master/semantic-release/README.md.
