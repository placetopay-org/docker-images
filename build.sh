#!/bin/bash

BUILD_NAME=$1
BUILD_VERSION=$2
PUSH=$3
PUSH_TAG=$4

if [ -z "$BUILD_NAME" ]; then
  echo "Provide an image to build, options are:"
  echo -e "\tphp-vapor"
  echo -e "\tphp-image"
  echo -e "\tmysql"
  echo -e "Example\n\t./build.sh php-vapor php74 -p"
  exit
fi

if [ -z "$BUILD_VERSION" ]; then
  echo "Provide a version to build, options are:"
  echo -e "\tphp74"

  echo -e "\tphp80"
  echo -e "\tphp80-pipeline"

  echo -e "\tphp81"
  echo -e "\tphp81-cloudhsm"
  echo -e "\tphp81-pipeline"

  echo -e "\tphp82"
  echo -e "\tphp82-cloudhsm"
  echo -e "\tphp82-pipeline"
  echo -e "\tphp82-arm"
  echo -e "\tphp82-arm-pipeline"

  echo -e "\tphp83"
  echo -e "\tphp83-pipeline"

  echo -e "\tphp84"
  echo -e "\tphp84-cloudhsm"
  echo -e "\tphp84-pipeline"
  echo -e "\tphp84-arm"
  echo -e "\tphp84-arm-pipeline"

  echo -e "\tphp85"
  echo -e "\tphp85-pipeline"

  echo -e "Example\n\t./build.sh php-vapor php74 -p"
  exit
fi

if [ -z "$PUSH_TAG" ]; then
  PUSH_TAG=$BUILD_VERSION
fi

echo "Running build for placetopay/${BUILD_NAME}:$BUILD_VERSION"

# php82-pipeline needs an build argument for vapor image
if [[ "$BUILD_VERSION" == *"php82-arm"* ]] || [[ "$BUILD_VERSION" == *"php84-arm"* ]]; then
  docker build --platform linux/amd64 -t placetopay/${BUILD_NAME}:${BUILD_VERSION} ${BUILD_NAME}/${BUILD_VERSION} --build-arg __VAPOR_RUNTIME=docker-arm
else
  docker build -t placetopay/${BUILD_NAME}:${BUILD_VERSION} ${BUILD_NAME}/${BUILD_VERSION}
#  docker build --platform linux/amd64 -t placetopay/${BUILD_NAME}:${BUILD_VERSION} ${BUILD_NAME}/${BUILD_VERSION}
fi

if [ $? -ne 0 ]; then
  echo "We have an error - build failed!"
  exit $?
fi

if [[ ! -z "$PUSH" ]]; then
  echo "Pushing image to DockerHub"
  docker push placetopay/${BUILD_NAME}:${PUSH_TAG}
fi
