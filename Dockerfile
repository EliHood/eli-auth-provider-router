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
RUN yarn install --frozen-lockfile --production --ignore-engines
RUN yarn run package-install && yarn run examples-install
RUN yarn build
CMD ["yarn", "run", "server"]
# CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
