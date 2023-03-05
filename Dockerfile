FROM node:18.14.2-alpine
RUN apk update && apk add git && apk add --no-cache curl && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
WORKDIR /home/app
COPY heroku.sh .

# heroku wont know what our directories are
COPY package.json ./
COPY lerna.json ./
COPY tsconfig.base.json ./

RUN yarn install --frozen-lockfile --production --ignore-engines && yarn cache clean

COPY ./examples /home/app/examples/

COPY ./packages/@core/auth-provider-router /home/app/packages/@core/auth-provider-router/

# docker does not like yarn run bootstrap for some reason, as its failing.
RUN yarn run bootstrap
RUN yarn build
CMD ["yarn", "run", "server"]
