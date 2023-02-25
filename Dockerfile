FROM node:alpine
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git
RUN apk --no-cache add curl
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
USER root:root
RUN yarn install --ignore-engines
RUN curl https://cli-assets.heroku.com/install.sh 
RUN yarn bootstrap
CMD ["yarn", "build:prod"]
