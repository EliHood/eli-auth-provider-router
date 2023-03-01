FROM node:18.14.2-alpine
# FROM sineverba/heroku-cli
WORKDIR /home/app
COPY package.json ./
COPY lerna.json ./
RUN apk update && apk add git && apk add --no-cache curl && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
RUN yarn install --ignore-engines && yarn cache clean && yarn bootstrap && yarn build
EXPOSE 3001
CMD ["yarn", "server"]
