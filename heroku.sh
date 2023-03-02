#!/usr/bin/env sh

echo 'Deploying to heroku'
set -x
yarn install 
yarn run bootstrap
yarn run build
yarn run server
set +x