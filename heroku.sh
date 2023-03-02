#!/usr/bin/env sh

echo 'Deploying to heroku'
set -x
yarn install 
yarn bootstrap
yarn build
yarn run server
set +x