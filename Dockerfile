FROM node:alpine
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git
RUN apk --no-cache add curl
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
USER root:root
RUN yarn install --ignore-engines
RUN yarn bootstrap
EXPOSE 3001
CMD ["yarn", "build:prod"]
