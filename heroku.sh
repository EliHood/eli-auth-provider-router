#!/bin/sh

echo 'Deploying to heroku'
set -x
yarn run server
set +x