#!/bin/sh

echo 'Deploying to heroku'
set -x
yarn install
yarn run bootstrap
sleep 10
yarn run build
yarn run server
set +x