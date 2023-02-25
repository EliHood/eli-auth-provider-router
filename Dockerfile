FROM node:alpine
FROM sue445/heroku-cli
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
RUN pip install docker-squash
RUN docker-squash --version
USER root:root
RUN yarn install --ignore-engines
RUN heroku --version
RUN yarn bootstrap
EXPOSE 3001

CMD ["yarn", "build:prod"]
