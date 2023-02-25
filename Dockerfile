FROM node:18.14.2-alpine
FROM sue445/heroku-cli
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
RUN yarn install --production && yarn cache clean --ignore-engines

EXPOSE 3001
CMD ["yarn", "build:prod"]
