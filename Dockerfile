
# Basic setup Option
# FROM nginx:1.17.1-alpine
# COPY nginx-custom.conf /etc/nginx/nginx-custom.conf
# COPY /dist/angular-blob-storage /usr/share/nginx/html
FROM node:17.0-alpine3.12 AS build

RUN apk add util-linux pciutils usbutils coreutils binutils findutils grep
RUN apk add bash bash-doc bash-completion
RUN apk add curl
RUN apk add --update nodejs nodejs-npm



### STAGE 1: Build ###
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm -v
RUN npm install
COPY . .
RUN npm run build
### STAGE 2: Run ###
FROM nginx:1.21.3-alpine
COPY nginx-custom.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/angular-blob-storage /usr/share/nginx/html