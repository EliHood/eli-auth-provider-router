FROM node:alpine
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
RUN yarn install --ignore-engines
EXPOSE 3001
CMD ["yarn", "build"]