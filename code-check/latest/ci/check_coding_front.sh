#!/usr/bin/env bash

set -e


cd $BITBUCKET_CLONE_DIR

eslint  --resolve-plugins-relative-to=$(npm root -g) -c /home/.eslintrc.js --no-eslintrc --ignore-path /home/.eslintignore  resources