#!/bin/bash

PHP_VERSION=$1
PUBLISH=$2

docker build -f ${PWD}/${PHP_VERSION}.Dockerfile -t vapor-${PHP_VERSION}:latest .

docker tag vapor-${PHP_VERSION}:latest placetopay/php-vapor:${PHP_VERSION}

if [ -n "$PUBLISH" ]; then
  docker push placetopay/php-vapor:${PHP_VERSION}
fi





#!/bin/bash

helpFunction()
{
   echo "Usage: $0 -a action"
   echo -e "\t-a put In case that you want to upload the files, add -s if Sura was processed"
   echo -e "\t-s Does upload into Sura"
   exit 1
}

while getopts "p:" opt
do
   case "$opt" in
      p ) push="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done

echo "Running process $action"

if [[ ! -z "$push" ]]; then

  echo "Cleaning remaining processed files"
  mv csv_process/output/* csv_process/input/* axa/
  echo "Cleaning finished"

fi