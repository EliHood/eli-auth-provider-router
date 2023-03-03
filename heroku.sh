#!/bin/sh

echo 'Deploying to heroku'
set -x
yarn run init-server
yarn install 
yarn run bootstrap
yarn run build
yarn run server
set +x