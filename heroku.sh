#!/bin/sh

echo 'Deploying to heroku'
set -x
echo "$PORT"
sed -i -e 's/$PORT/'"$PORT"'/g' ./nginx.conf && nginx -g 'daemon off;'
yarn install 
yarn run bootstrap
yarn run build
yarn run server
set +x