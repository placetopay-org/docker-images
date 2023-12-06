#!/bin/bash

PHP_IMAGE=$1
PHP_VERSION=$2

docker run --platform linux/amd64 -it ${PHP_IMAGE}-${$PHP_VERSION}:latest /bin/bash
