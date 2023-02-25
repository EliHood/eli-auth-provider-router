FROM node:alpine
FROM sue445/heroku-cli
COPY . /home/app
WORKDIR /home/app
COPY package.json ./
RUN apk update && apk add git
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir nibabel pydicom matplotlib pillow med2image
    # Note: we had to merge the two "pip install" package lists here, otherwise
    # the last "pip install" command in the OP may break dependency resolution…
RUN pip install docker-squash
RUN docker-squash --version
USER root:root
RUN yarn install --ignore-engines
RUN heroku --version
RUN yarn bootstrap
EXPOSE 3001

CMD ["yarn", "build:prod"]
