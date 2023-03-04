#!/bin/sh

echo 'Deploying to heroku'
set -x
echo "$PORT"
yarn install 
yarn run bootstrap
yarn run build
yarn run server
set +x