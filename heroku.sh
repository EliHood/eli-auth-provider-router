#!/bin/sh

echo 'Deploying to heroku'
set -x
yarn run bootstrap
yarn run build
yarn run server
set +x