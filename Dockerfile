FROM node:18.14.2-alpine
COPY package.json ./
COPY lerna.json ./
RUN apk update && apk add git && apk add --no-cache curl && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
WORKDIR /home/app
COPY heroku.sh .

# heroku wont know what our directories are
# COPY . .

# docker does not like yarn run bootstrap for some reason, as its failing. 
# RUN yarn run package-install && yarn run examples-install
# RUN yarn run bootstrap /home/app

COPY examples ./  /home/app/examples/
COPY examples/package.json /home/app/examples/
COPY examples/yarn.lock /home/app/examples/

COPY packages/@core/auth-provider-router ./  /home/app/packages/@core/auth-provider-router/
COPY packages/@core/auth-provider-router/package.json  /home/app/packages/@core/auth-provider-router/
COPY packages/@core/auth-provider-router/yarn.lock  /home/app/packages/@core/auth-provider-router/

RUN yarn install --frozen-lockfile --production --ignore-engines && yarn cache clean

RUN yarn build
CMD ["yarn", "run", "server"]
