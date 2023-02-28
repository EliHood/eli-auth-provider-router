FROM node:18.14.2-alpine
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git && apk add --no-cache curl && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
FROM escaleno/heroku-cli:7.42.2
RUN yarn install --production && yarn cache clean --ignore-engines
EXPOSE 3001
CMD ["yarn", "bootstrap"]
CMD ["yarn", "build:prod"]
