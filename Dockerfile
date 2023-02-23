FROM node:alpine
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
USER root:root
RUN yarn install --ignore-engines
RUN yarn bootstrap
EXPOSE 3001

CMD ["yarn", "build:prod"]
