FROM nginx:1.21.6-alpine

LABEL org.opencontainers.image.source=https://github.com/provenance-io/gas-price-service

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./gas-prices.json /usr/share/nginx/html/gas-prices.json