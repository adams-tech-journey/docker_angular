
FROM nginx:1.17.1-alpine
COPY nginx-custom.conf /etc/nginx/nginx-custom.conf
COPY /dist/angular-blob-storage /usr/share/nginx/html

