FROM node:18.14.2-alpine
COPY package.json ./
COPY lerna.json ./
RUN apk update && apk add git && apk add --no-cache curl && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
WORKDIR /home/app
COPY heroku.sh .

# heroku wont know what our directories are
COPY . .
EXPOSE $PORT
RUN yarn install --production --ignore-engines && yarn cache clean 

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -e 's/$PORT/'"$PORT"'/g' && nginx -g 'daemon off;'
