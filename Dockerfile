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
FROM httpd:alpine
WORKDIR /usr/local/apache2/htdocs
COPY --from=build /build/build/ .
RUN chown -R www-data:www-data /usr/local/apache2/htdocs \
    && sed -i "s/Listen 80/Listen \${PORT}/g" /usr/local/apache2/conf/httpd.conf
EXPOSE 3001

CMD ["yarn", "build:prod"]
