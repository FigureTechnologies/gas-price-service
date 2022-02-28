FROM nginx:1.21.6-alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./gas-prices.json /usr/share/nginx/html/gas-prices.json