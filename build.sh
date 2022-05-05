#!/bin/bash

PHP_VERSION=$1
PUSH=$2

if [ -z "$PHP_VERSION" ]; then
  echo "Provide an image to build, options are:"
  echo "php74"
  echo "php80"
  echo "php80-pipeline"
  echo "php81"
  echo "php81-pipeline"
  exit
fi

echo "Running build for $PHP_VERSION"
docker build -t vapor-${PHP_VERSION}:latest ${PHP_VERSION}

if [ $? -ne 0 ]; then
  echo "We have error - build failed!"
  exit $?
fi

echo "Tagging the version as latest"
docker tag vapor-${PHP_VERSION}:latest placetopay/php-vapor:${PHP_VERSION}

if [[ ! -z "$PUSH" ]]; then
  echo "Pushing image to DockerHub"
  docker push placetopay/php-vapor:${PHP_VERSION}
fi
