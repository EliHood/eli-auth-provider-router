FROM node:18.14.2-alpine
COPY package.json ./
COPY lerna.json ./
RUN apk update && apk add git && apk add --no-cache curl && apk add --update python3 make g++ && rm -rf /var/cache/apk/* 
USER root:root
WORKDIR /home/app
COPY heroku.sh .

# heroku wont know what our directories are
COPY . .
USER root:root
RUN yarn install --frozen-lockfile --production --ignore-engines && yarn cache clean
# docker does not like yarn run bootstrap for some reason, as its failing. 
RUN yarn run package-install && yarn run examples-install
RUN yarn build
CMD ["yarn", "run", "server"]
