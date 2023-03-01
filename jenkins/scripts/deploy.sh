#!/usr/bin/env sh

APP_NAME = 'eli-auth-provider-router'

echo "Login to heroku"
heroku --version                 
echo HEROKU_API_KEY  | heroku container:release web --app=$APP_NAME    