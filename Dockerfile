FROM node:alpine
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git && apt-get install -y curl
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
USER root:root
RUN yarn install --ignore-engines
RUN curl https://cli-assets.heroku.com/install.sh 
RUN yarn bootstrap
EXPOSE 3001

CMD ["yarn", "build:prod"]
