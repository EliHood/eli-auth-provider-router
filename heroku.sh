#!/bin/sh

echo 'Deploying to heroku'
set -x
yarn install 
sleep 20
yarn run bootstrap
yarn run build
yarn run server
set +x